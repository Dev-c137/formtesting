//
//  ViewController.swift
//  formtesting
//
//  Created by Devang Pawar on 07/06/20.
//  Copyright © 2020 Devang Pawar. All rights reserved.
//

import UIKit
import Eureka
import CoreData

class PatientFormViewController: FormViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var detail: Details? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createForm()
        
    }

}
//MARK: - saving 
extension PatientFormViewController {
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error while saving \(error)")
        }
    }
}

//MARK: - creating form
extension PatientFormViewController {
    func createForm() {
        let dd = Details(context: context)
        form
            +++ Section("Identification")
            <<< IntRow(){
                $0.title = "File Number"
                $0.placeholder = "Enter file number"
            }.onChange({ (IntRow) in
                if let value = IntRow.value { dd.fileNumber = Double(value) }
            })
            <<< NameRow("Enter name"){
                $0.placeholder = "Enter name"
                $0.title = "Name"
            }.onChange({ (NameRow) in
                if let value = NameRow.value { dd.name = value }
            })
            <<< ButtonRow(){
                $0.title = "Done"
            }.onChange({_ in
                self.detail = dd
                self.saveData()
            })
    }
}

