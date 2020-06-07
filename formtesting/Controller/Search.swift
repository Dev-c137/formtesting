//
//  Search.swift
//  formtesting
//
//  Created by Devang Pawar on 07/06/20.
//  Copyright © 2020 Devang Pawar. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var all = [Details]()
    
    override func viewDidLoad() {
        saveData()
        loadItems()
    }
}
//MARK: - searching
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
        loadItems(with: predicate)
        print("search pressed")
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

//MARK: - saving and loading data
extension SearchViewController {
    func saveData() {
        do {
            try context.save()
        } catch {
            print("\(error) error saving")
        }
        tableView.reloadData()
    }
    
    
    func loadItems(with predicate: NSPredicate? = nil) {
        let request: NSFetchRequest<Details> = Details.fetchRequest()
        if let givenPredicate = predicate {
            request.predicate = givenPredicate
            print("here")
        }
        let sorting = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sorting]
        do {
            all = try context.fetch(request)
        } catch {
            print("error while loading\(error)")
        }
        tableView.reloadData()
    }
}
//MARK: - tableview loading

extension SearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        all.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        cell.textLabel?.text = all[indexPath.row].name
        
        return cell
    }
}
