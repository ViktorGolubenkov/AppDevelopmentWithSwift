//
//  AddRegistrationTableViewController.swift
//  HotelManzana2020
//
//  Created by Viktor Golubenkov on 09.10.2020.
//

import UIKit


class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    var roomType: RoomType?
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    var registration: Registration? {
        
        guard let roomType = roomType else { return nil }
        
        let firstName = firstNameTextField.text ?? "First Name"
        let lastName = lastNameTextField.text ?? "Last Name"
        let email = emailTextField.text ?? "Email"
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        
        return Registration(
            firstName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberOfAdults, numberOfChildren: numberOfChildren, roomType: roomType, wifi: hasWifi
        )
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        checkInDatePicker.preferredDatePickerStyle = .inline
        checkOutDatePicker.preferredDatePickerStyle = .inline
        
        updateDoneButtonState()
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
    }
    
    func updateDateViews() {
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    func updateNumberOfGuests() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    func updateRoomType() {
        roomTypeLabel.text = roomType?.name ?? "Not Set"
    }
    
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    // for enabling Done button
    func updateDoneButtonState() {
        let firstName = firstNameTextField.text ?? "First Name"
        let lastName = lastNameTextField.text ?? "Last Name"
        let email = emailTextField.text ?? "Email"
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        doneButton.isEnabled = !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && (numberOfAdults.hashValue != 0)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row):
            if isCheckInDatePickerShown {
                return 216.0
            } else {
                return 0.0
            }
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row):
            if isCheckOutDatePickerShown {
                return 216.0
            } else {
                return 0.0
            }
        default:
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row - 1):
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            } else {
                isCheckInDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row - 1):
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                isCheckOutDatePickerShown = true
            } else {
                isCheckOutDatePickerShown = true
            }
        default:
            isCheckInDatePickerShown = false
            isCheckOutDatePickerShown = false
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomType" {
            let destinationViewController = segue.destination as? SelectRoomTypeTableViewController
            destinationViewController?.delegate = self
            destinationViewController?.roomType = roomType
        }
    }
    
    
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        let firstName = firstNameTextField.text ?? "First Name"
        let lastName = lastNameTextField.text ?? "Last Name"
        let email = emailTextField.text ?? "Email"
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        let roomChoice = roomType?.name ?? "Not Set"
        
        print("First Name: \(firstName)")
        print("Last Name: \(lastName)")
        print("Email: \(email)")
        print("CheckIn: \(checkInDate)")
        print("CheckOut: \(checkOutDate)")
        print("Number of Adults: \(numberOfAdults)")
        print("Number of Children: \(numberOfChildren)")
        print("WiFi: \(hasWifi)")
        print("Room Type: \(roomChoice)")
    }
    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // checking textFields and adults stepper (3 fields and 1 stepper connected)
    @IBAction func editedFields(_ sender: Any) {
        updateDoneButtonState()
    }
    
    
}


