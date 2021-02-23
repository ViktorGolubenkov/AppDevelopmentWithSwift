//
//  RegistrationTableViewController.swift
//  HotelManzana2020
//
//  Created by Viktor Golubenkov on 10.10.2020.
//

import UIKit


class RegistrationTableViewController: UITableViewController {

    var registrations = [Registration]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)
        
        let registration = registrations[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        cell.textLabel?.text = registration.firstName + " " + registration.lastName
        cell.detailTextLabel?.text = dateFormatter.string(from: registration.checkInDate) + " - " + dateFormatter.string(from: registration.checkOutDate) + ": " + registration.roomType.name
        
        // added order control(1)
        cell.showsReorderControl = true
        
        return cell
    }
    
    // added order control(2)
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            registrations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
        }
    }
    
    // added order control(3)
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedRecord = registrations.remove(at: fromIndexPath.row)
        registrations.insert(movedRecord, at: to.row)
        tableView.reloadData()
    }
    


    @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue) {
        guard let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController,
              let registration = addRegistrationTableViewController.registration else { return }
     
        registrations.append(registration)
        tableView.reloadData()
    }
    // added order control(3)
    @IBAction func editButtonTapped(_ sender: Any) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    
    

}
