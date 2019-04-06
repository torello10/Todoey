//
//  ViewController.swift
//  Todoey
//
//  Created by Salvatore La spina on 06/04/2019.
//  Copyright © 2019 Salvatore La spina. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy a grocieries", "Destory Demorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    //MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
           tableView.cellForRow(at: indexPath)?.accessoryType = .none
            tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.black
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            tableView.cellForRow(at: indexPath)?.textLabel?.textColor = UIColor.red
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
  
    }
    
    
    //MARK - Add new Item
    
    
    @IBAction func AddItem(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let action = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        action.addAction(UIAlertAction(title: "Add Item", style: .default) { (action) in
            if textField.text != ""{
                self.itemArray.append(textField.text!)
                self.tableView.reloadData()
            }
        })
        
       action.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
        textField = alertTextField
            
        }
        
        self.present(action, animated: true, completion: nil)
        }
 
    
}

