//
//  ViewController.swift
//  Newdoey
//
//  Created by Michal Dabrowski on 02/07/2019.
//  Copyright © 2019 Michal Dabrowski. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Category 1"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Category 2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Category 3"
        itemArray.append(newItem3)
        
     
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }

        
    }

    
    //MARK - Tableview Datasource Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        

//        the conditional below has been replaced with a TURNERY OPERATOR above =>
        //        value (here cell.accessoryType) = condition ? valueIfTrue : valueIfFalse
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    
    //MARK - TableView Delegate Methods   (it detects what has been selected and what to do about it:)
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(itemArray[indexPath.row])
        
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//          the line above replaces the conditional below (because it is a boolien)
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
//
        tableView.reloadData()
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    
    
    //MARK Add new items section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController (title: "Add New Newdoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction (title: "Add Item", style: .default) { (action) in
            //what will happen once the used clicks the Add Item button on UIALert
//           print(textField.text)
            
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
//            print(alertTextField.text)
//            print("Now")
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
        
    }
    

}

