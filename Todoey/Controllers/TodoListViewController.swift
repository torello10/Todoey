//
//  ViewController.swift
//  Todoey
//
//  Created by Salvatore La spina on 06/04/2019.
//  Copyright © 2019 Salvatore La spina. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
         print(dataFilePath)
      
        loadItems()
    }
    
    //MARK - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        self.saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
  
    }
    
    
    //MARK - Add new Item
    
    
    @IBAction func AddItem(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let action = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        action.addAction(UIAlertAction(title: "Add Item", style: .default) { (action) in
            if textField.text != ""{
                
                let newItem = Item()
                newItem.title = textField.text!
                self.itemArray.append(newItem)
                
                self.saveItems()
                
            }
        })
        
       action.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
        textField = alertTextField
            
        }
        
        self.present(action, animated: true, completion: nil)
        }
 
    //MARK -Manipulation model method
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch {
            print("Error encoding item Array \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding item Array \(error)")
            }
        }
    }
}

