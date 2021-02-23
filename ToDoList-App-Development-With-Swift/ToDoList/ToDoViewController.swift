//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Viktor Golubenkov on 16.10.2020.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var todo: ToDo?
    
    var isPickerHide = true
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let notesTextViewIndexPath = IndexPath(row: 0, section: 2)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // condition for adding or editing rows
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(86400) // picker + 24 hours
    }
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
    }
    
    
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    // converting date to string through "dateFormatter" method from "ToDo" model (1)
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter().string(from: date)
    }
 
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch indexPath {
        case [1, 0]:
            return isPickerHide ? normalCellHeight : largeCellHeight
        case [2, 0]:
            return largeCellHeight
        default:
            return normalCellHeight
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "SaveUnwind" else { return }
        
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
    }
    
    
    
    @IBAction func textEditingChanged(_ sender: Any) {
        updateSaveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: Any) {
        titleTextField.resignFirstResponder()
    }
    
    // change button view mark/unmark
    @IBAction func isCompleteButtonTapped(_ sender: Any) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    // updating chosen date (2)
    @IBAction func datePickerChanged(_ sender: Any) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    
    
}
