//
//  AppDelegate.swift
//  swiftdemo
//
//  Created by luosai19910103@163.com on 15/9/28.
//  Copyright © 2015年 . All rights reserved.
//

import UIKit
import CoreData
class PersonListTableViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    
    struct TableViewConstants{
        static let cellIdentifier = "Cell"
    }
    var frc: NSFetchedResultsController!
    var managerObjectContext: NSManagedObjectContext?{
        return CoreDataManager.coreDataManager.managedObjectContext
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        if(type == .Delete){
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
        }else if type == .Insert{
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       let sectionInfo = frc.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: TableViewConstants.cellIdentifier)
        let person = frc.objectAtIndexPath(indexPath) as! Person

        cell.textLabel!.text = "Name: \(person.name!)"
        cell.detailTextLabel!.text = "Phone:\(person.phoneNum!)"
        return cell
        
    }

   
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            let personToDelete = self.frc.objectAtIndexPath(indexPath) as! Person
            print("managerObjectContext \(managerObjectContext)")
            managerObjectContext!.deleteObject(personToDelete)
            if  personToDelete.deleted{
                do{
                    try managerObjectContext!.save()
                    print("successful deleted the object")
                }catch let error as NSError{
                    
                    print("Failed to save the context with error = \(error)")
                }
            }
            

        }
    }
    
//    override func tableView(tableView: UITableView,
//        editingStyleForRowAtIndexPath indexPath: NSIndexPath)
//        -> UITableViewCellEditingStyle {
//            return .Delete
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let fetchRequst = NSFetchRequest(entityName: "Person")
        
        let ageSort = NSSortDescriptor(key: "age", ascending: true)
        
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequst.sortDescriptors = [ageSort,nameSort]
        
        frc = NSFetchedResultsController(fetchRequest: fetchRequst, managedObjectContext: managerObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        
        frc.delegate = self
        
        do {
            try frc.performFetch()
        }catch let error as NSError{
            print("performFetch error :\(error)")
        }
        
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    }


}















