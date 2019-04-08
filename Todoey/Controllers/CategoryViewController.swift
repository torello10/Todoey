//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Salvatore La spina on 07/04/2019.
//  Copyright © 2019 Salvatore La spina. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryViewController: SwipeTableViewController {
    
    
    
    var categoryArray : Results<Category>?
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
        

    }

    
    
    //MARK: - Table View Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        let category = categoryArray?[indexPath.row]
        
        cell.textLabel?.text = category?.name ?? "No Categories added yet"
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    
    //MARK: - Table Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

      performSegue(withIdentifier: "goToItem", sender: self)

        tableView.deselectRow(at: indexPath, animated: true)

   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectCategory = categoryArray?[indexPath.row]
        }
    }
 
    //MARK: - Add new Category
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
       
        var textField = UITextField()
        
        let action = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        action.addAction(UIAlertAction(title: "Add Category", style: .default) { (action) in
            if textField.text != ""{
                
                
                
                let newCategory = Category()
                newCategory.name = textField.text!
                
                self.saveCategories(category: newCategory)
                
            }
        })
        
        action.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
            
        }
        
        self.present(action, animated: true, completion: nil)
    }
    
    //MARK: - Manipulation model method
    
    func saveCategories(category: Category){
        
        
        do{
            try realm.write {
                realm.add(category)
            }
        }catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories(){
        
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
   }
  
    
    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let category = self.categoryArray?[indexPath.row] {
            do{
               try self.realm.write {
                   self.realm.delete(category)
               }
            }catch {
                print("Error deleting context \(error)")
            }
        }
    }

}




