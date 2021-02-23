//
//  CategoryTableViewController.swift
//  RestaurantOrder
//
//  Created by Viktor Golubenkov on 30.10.2020.
//

import UIKit

class CategoryTableViewController: UITableViewController {
   
    var categories = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: MenuController.menuDataUpdateNotification, object: nil)
        
        updateUI()
    }

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCellIdentifier", for: indexPath)
        configure(cell, forItemAt: indexPath)

        return cell
    }
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let categoryString = categories[indexPath.row]
        cell.textLabel?.text = categoryString.capitalized
    }
    
    
    @objc func updateUI() {
        categories = MenuController.shared.categories
        
        tableView.reloadData()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuSegue" {
            let menuTableViewController = segue.destination as! MenuTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            menuTableViewController.category = categories[index]
        }
        
    }
    

}
