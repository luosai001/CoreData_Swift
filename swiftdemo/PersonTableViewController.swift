//
//  AppDelegate.swift
//  swiftdemo
//
//  Created by luosai19910103@163.com on 15/9/28.
//  Copyright © 2015年 . All rights reserved.
//

import UIKit
import CoreData


class PersonTableViewController: UITableViewController {


    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var ageTextfield: UITextField!
    
    override func viewDidLoad() {
        
        self.tableView.tableFooterView = UIView(frame:CGRectZero )
    }
    override func viewDidAppear(animated: Bool) {
        self.nameTextField.becomeFirstResponder()
    }
    @IBAction func saveAddressBook(sender: AnyObject) {
        
        if(newPerson()){
            
            self.navigationController?.popViewControllerAnimated(true)

        }
        
    }
    
    func newPerson()->Bool{
        
        let managerObjectContext = CoreDataManager.coreDataManager.managedObjectContext
        
        let newPerson = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: managerObjectContext) as? Person
        
        if let person = newPerson {
            person.name = self.nameTextField.text
            if let phoneNum = Int(self.phoneTextfield.text!){
                person.phoneNum = phoneNum

            }
            
            if let age = Int(self.ageTextfield.text!){
                person.age = age
            }
            do{
                try  managerObjectContext.save()
                return true
            }catch let error as NSError{
                print("failed to save :\(error) ")
            }
        }else{
            print("failed to creat new person")
        }
        return false
    }
}
