
import UIKit


class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate, SelectEmployeeTypeDelegate {
   
    struct PropertyKeys {
        static let unwindToListIndentifier = "UnwindToListSegue"
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var employeeTypeLabel: UILabel!
    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!
    
    var employee: Employee?
    var employeeType: EmployeeType?

    var isEditingBirthday: Bool = false {
        didSet {
            dateOfBirthPicker.isHidden = !isEditingBirthday
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
       //     dateOfBirthPicker.preferredDatePickerStyle = .inline
        
        updateView()
        tableView.reloadData()
        
    }
    
    func didSelect(employeeType: EmployeeType) {
        self.employeeType = employeeType
        employeeTypeLabel.text = employeeType.description()
        employeeTypeLabel.textColor = .black
    }
    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
          //  let dateFormatter = DateFormatter()
          //  dateFormatter.dateStyle = .medium
            dobLabel.text = dateFormatter(dateOfBirthPicker.date)
            dobLabel.textColor = .black
            employeeTypeLabel.text = employee.employeeType.description() 
            employeeTypeLabel.textColor = .black
        } else {
            navigationItem.title = "New Employee"
        }
    }
    
    func dateFormatter(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: date)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return isEditingBirthday ? 44.0 : 0.0
        }
        return 44.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
            isEditingBirthday = !isEditingBirthday
            
            dobLabel.textColor = .black
            dobLabel.text = dateFormatter(dateOfBirthPicker.date)
        }
    }

    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let name = nameTextField.text, let employeeType = employeeType {
            employee = Employee(name: name, dateOfBirth: dateOfBirthPicker.date, employeeType: employeeType)
            performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
        performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
    }
    
    @IBAction func birthdayValueChanged(_ sender: UIDatePicker) {
        dobLabel.text = dateFormatter(dateOfBirthPicker.date)
    }
    
    // MARK: - Text Field Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let employeeTypeController = segue.destination as? EmployeeTypeTableViewController else { return }
            employeeTypeController.delegate = self
            employeeTypeController.employeeType = employee?.employeeType
        
    }
    

}
