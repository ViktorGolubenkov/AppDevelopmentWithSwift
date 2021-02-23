//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Viktor Golubenkov on 02.10.2020.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    
    var emojis = [Emoji]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // checking new emoji (empty -> load sample) 
        if let savedEmojis = Emoji.loadFromFile() {
            emojis = savedEmojis
        } else {
            emojis = Emoji.loadSampleEmojis()
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let tableViewEditingMode = tableView.isEditing
     
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    @IBAction func unwindToEmojiTableViewController(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! AddEditEmojiTableViewController
        
        if let emoji = sourceViewController.emoji {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                emojis[selectedIndexPath.row] = emoji
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: emojis.count, section: 0)
                emojis.append(emoji)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        // saving new emoji, call "saveToFile" function
        Emoji.saveToFile(emojis: emojis)
    }
    
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        if section == 0 {
            return emojis.count
            } else {
                return 0
            }
        // or simply: "return emojis.count"
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell
        
        let emoji = emojis[indexPath.row]
        // let _ = _ [indexPath.section] - for sections
        
        // "default style":
        //cell.textLabel?.text = "\(emoji.symbol) - \(emoji.name)"
        //cell.detailTextLabel?.text = emoji.description
        
        // for new custom cell
        cell.update(with: emoji)
        
        // add this property for editing order of cells
        cell.showsReorderControl = true
        
        return cell
    }


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // for delete emoji from array
            emojis.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            
        }
    }

    
    // enabling delete rows
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    
    // when you want to re-order rows, you should remove cell and add it back
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedEmoji = emojis.remove(at: fromIndexPath.row)
        emojis.insert(movedEmoji, at: to.row)
        tableView.reloadData()
        
        // for saving re-ordered rows, call "saveToFile" function
        Emoji.saveToFile(emojis: emojis)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditEmoji" {
            let indexPath = tableView.indexPathForSelectedRow!
            let emoji = emojis[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let addEditEmojiTableViewController = navController.topViewController as! AddEditEmojiTableViewController
            
            addEditEmojiTableViewController.emoji = emoji
        }
    
    }
    
    

}
