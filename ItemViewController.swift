//
//  ItemViewController.swift
//  todoey
//
//  Created by Kavya Joshi on 06/04/19.
//  Copyright © 2019 Kavya Joshi. All rights reserved.
//

import UIKit
import RealmSwift

class ItemViewController: UITableViewController {

    
    let realm = try! Realm()
    
   
    var toDoItems : Results<Item>?
    
    var parentCategory : Category?
    {
        didSet{
            
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       
        print(toDoItems?.count)
         return toDoItems? .count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        if let itemToBeDisplay = toDoItems?[indexPath.row]
        {
            cell.textLabel?.text = itemToBeDisplay.task
        cell.accessoryType = itemToBeDisplay.done ? .checkmark : .none
        
        }
        else {
             cell.textLabel?.text = "No Items added"
        }
   

        return cell
    }
    



    @IBAction func AddItems(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let Alert = UIAlertController(title: "Add Item", message: "  ", preferredStyle: .alert)
       
        let action = UIAlertAction(title: "Add", style: .default)
        { (action) in
            print("1\(self.parentCategory?.name)")
        
            // unwrap the selected category...if present
            if let currentCategory = self.parentCategory
            {
                
                do{
                   try self.realm.write
                   {
                    print("2\(currentCategory.name)")
                        let newitem = Item()
                         newitem.dateCreated = Date()
                        newitem.task = textfield.text!
                    
                    currentCategory.Items.append(newitem)
       
                    }
                    
                  }
                    catch {
                        print("Error = \(error)")
                          }
            }
                         self.tableView.reloadData()
        }
        Alert.addTextField
            { (text) in
                text.placeholder = "New Item"
                textfield = text
        }
        Alert.addAction(action)
        
        present(Alert, animated: true, completion:nil)
        
        
    

    }
    
    func loadItems()
    {
        toDoItems = parentCategory?.Items.sorted(byKeyPath: "task", ascending: true)
            
            tableView.reloadData()
        }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = toDoItems?[indexPath.row]{
        
        do{
            try realm.write{
                item.done = !item.done
            }}
              catch
             {
                print("Error saving the status \(error)")
              }
        
    }
    tableView.reloadData()
}
}
extension ItemViewController : UISearchBarDelegate
{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let predicate = NSPredicate(format: "task CONTAINS[cd] %@", searchBar.text!)
        toDoItems = toDoItems?.filter(predicate).sorted(byKeyPath: "dateCreated", ascending: true)
        print(toDoItems)
        tableView.reloadData()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    
    if searchBar.text?.count == 0
    {
    loadItems()
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
            
            self.tableView.reloadData()
            
                                 }
    }
    
    }
}
    

