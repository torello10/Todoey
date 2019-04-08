//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Salvatore La spina on 07/04/2019.
//  Copyright © 2019 Salvatore La spina. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }

    
    
    //MARK: - Table View Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    //MARK: - Table Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      performSegue(withIdentifier: "goToItem", sender: self)
        
      
        //        context.delete(itemArray[indexPath.row])
        //        itemArray.remove(at: indexPath.row)
        
        
        self.saveCategories()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectCategory = categoryArray[indexPath.row]
        }
    }
 
    //MARK: - Add new Category
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
       
        var textField = UITextField()
        
        let action = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        action.addAction(UIAlertAction(title: "Add Category", style: .default) { (action) in
            if textField.text != ""{
                
                
                
                let newCategory = Category(context: self.context)
                newCategory.name = textField.text!
               
                self.categoryArray.append(newCategory)
                
                self.saveCategories()
                
            }
        })
        
        action.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
            
        }
        
        self.present(action, animated: true, completion: nil)
    }
    
    //MARK: - Manipulation model method
    
    func saveCategories(){
        
        
        do{
            try context.save()
        }catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        //       let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data \(error)")
        }
        
    }
    
}

