//
//  MainVC.swift
//  CoreDataTest
//
//  Created by Fivecode on 15/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate ,UITableViewDataSource, NSFetchedResultsControllerDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentView: UISegmentedControl!
    
    var controller: NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
//        testData()
        attempFetchRequest()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = controller.sections {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ItemsViewCell
        
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    func configureCell(cell: ItemsViewCell, indexPath: NSIndexPath) {
        let item =  controller.object(at: indexPath as IndexPath)
        
        cell.configureCell(item: item)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = controller.fetchedObjects, objs.count > 0 {
            let item = objs[indexPath.row]
            //print(item)
            performSegue(withIdentifier: "itemDetailVC", sender: item)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemDetailVC" {
            if let destination = segue.destination as? DetailVC {
                if let item = sender as? Item {
                    destination.itemToEdit = item
                }
            }
        }
    }
    
    @IBAction func sorterPressed(_ sender: UISegmentedControl) {
        attempFetchRequest()
        tableView.reloadData()
    }
    
    func attempFetchRequest(){
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let priceSort = NSSortDescriptor(key: "price", ascending: true)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        
        if segmentView.selectedSegmentIndex == 0 {
            fetchRequest.sortDescriptors = [dateSort]
        }else if segmentView.selectedSegmentIndex == 1 {
            fetchRequest.sortDescriptors = [priceSort]
        }else{
            fetchRequest.sortDescriptors = [titleSort]
        }
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        self.controller = controller
        
        do {
            try controller.performFetch()
        } catch  {
            let err = error as NSError
            print("\(err)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemsViewCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
    func testData () {
        let item = Item(context: context)
        item.title = "Iphone 6s"
        item.price = 2000
        item.details = "I have Iphone 6s, this phone is wonder full"
        
        let item2 = Item(context: context)
        item2.title = "Macbook Pro"
        item2.price = 3000
        item2.details = "I want macbook pro, and i buy it"
        
        let item3 = Item(context: context)
        item3.title = "Iphone 5"
        item3.price = 1000
        item3.details = "I have Iphone 5, this phone is wonder full"
        
        ad.saveContext()
    }

}

