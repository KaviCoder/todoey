//
//  TableViewController.swift
//  todoey
//
//  Created by Kavya Joshi on 06/04/19.
//  Copyright © 2019 Kavya Joshi. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    
   let realm = try! Realm()
    
    var categories:Results<Category>?
    
   

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
            loadCategory()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        return cell
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems"
        {
            let destinationVC = segue.destination as! ItemViewController
            
            if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.parentCategory = categories?[indexPath.row]
            }}
    }
        
    
    
    @IBAction func AddCategory(_ sender: UIBarButtonItem) {
        print("bar")
        var alertfield = UITextField()
        
        let Alert = UIAlertController(title: "Add Category", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let cat = Category()
            
            cat.name = alertfield.text!
          
            self.savecategories(Category: cat)
            
        }
        
        
        Alert.addTextField { (text) in
        text.placeholder = "New Category"
            
            alertfield = text
        }
        
        Alert.addAction(action)
        present(Alert, animated: true, completion:nil)
        
        
               tableView.reloadData()
    }
    
    
    
    func savecategories(Category : Category)
    {
        
      
        do{
            try! realm.write{
                realm.add(Category)
                tableView.reloadData()
            }}
            
            catch{
                print("Error = \(error)")
                
        }
    }
    
    func loadCategory()
    {
        categories = realm.objects(Category.self)

        tableView.reloadData()
    }
    
}
