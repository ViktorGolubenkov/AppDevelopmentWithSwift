//
//  EmployeeTypeTableViewController.swift
//  EmployeeRoster
//
//  Created by Viktor Golubenkov on 15.10.2020.
//

import UIKit

protocol SelectEmployeeTypeDelegate {
    func didSelect(employeeType: EmployeeType)
}

class EmployeeTypeTableViewController: UITableViewController {
    
    var delegate: SelectEmployeeTypeDelegate?
    var employeeType: EmployeeType?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EmployeeType.all.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTypeIdentifier", for: indexPath)
        
        let type = EmployeeType.all[indexPath.row]
        cell.textLabel?.text = type.description()
        cell.accessoryType = type == self.employeeType ? .checkmark : .none
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        employeeType = EmployeeType.all[indexPath.row]
        delegate?.didSelect(employeeType: employeeType!)
        tableView.reloadData()
    }
    

}
