//
//  DetailVC.swift
//  CoreDataTest
//
//  Created by Fivecode on 15/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import UIKit
import CoreData

class DetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var detailField: UITextField!
    
    var stores = [Store]()
    
    var itemToEdit: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        storePicker.delegate = self
        storePicker.dataSource = self
//        setData()
        getStoreRequest()
        
        if itemToEdit != nil { loadItemData() }
    
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        return store.name
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func getStoreRequest() {
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
          stores = try context.fetch(fetchRequest)
        } catch let error{
            print("\(error)")
        }
    
    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailField.text = item.details
            
            if let store = item.toStore {
                
                var index = 0
                
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                    
                }while (index < stores.count)
                
            }
        }
    }
    
    func setData() {
        let stores = Store(context: context)
        stores.name = "Best Buy"
        let stores2 = Store(context: context)
        stores2.name = "Tesla Dealership"
        let stores3 = Store(context: context)
        stores3.name = "Frys Electronic"
        let stores4 = Store(context: context)
        stores4.name = "Target"
        let stores5 = Store(context: context)
        stores5.name = "Amazon"
        let stores6 = Store(context: context)
        stores6.name = "K Mart"
        
        ad.saveContext()
    }

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        let item: Item! = itemToEdit == nil ? Item(context: context) : itemToEdit
        
        item.title = titleField.text
        item.price = (priceField.text! as NSString).doubleValue
        item.details = detailField.text
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    
}
