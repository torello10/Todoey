//
//  ViewController.swift
//  Todoey
//
//  Created by Salvatore La spina on 06/04/2019.
//  Copyright © 2019 Salvatore La spina. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    var todoItems : Results<Item>?
     let realm = try! Realm()
    var selectCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
         print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
//       loadItems()
    }
    
    //MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
            
        }else {
            cell.textLabel?.text = "No item added"
        }

        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do{
               try realm.write {
  //                  realm.delete(item)
                    item.done = !item.done
                }
            }catch{
                print("error saving status \(error)")
            }
        }
        tableView.reloadData()
    
        
        tableView.deselectRow(at: indexPath, animated: true)
  
    }
    
    
    //MARK: - Add new Item
    
    
    @IBAction func AddItem(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let action = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        action.addAction(UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectCategory {
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("Error saving new Item \(error)")
            }
              self.tableView.reloadData()
            }
        })
        
       action.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
        textField = alertTextField
            
        }
        
        self.present(action, animated: true, completion: nil)
        
        }
 
    //MARK: - Manipulation model method
    
    func loadItems(){

        todoItems = selectCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
      tableView.reloadData()
    }
}

//MARK: - Search bar methods

extension TodoListViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()

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

