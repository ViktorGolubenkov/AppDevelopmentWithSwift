//
//  ToDoCellTableViewCell.swift
//  ToDoList
//
//  Created by Viktor Golubenkov on 18.10.2020.
//

import UIKit

protocol ToDoCellDelegate: class {
    func checkmarkTapped(sender: ToDoCellTableViewCell)
}

class ToDoCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!

    var delegate: ToDoCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    @IBAction func completeButtonTapped(_ sender: Any) {
        delegate?.checkmarkTapped(sender: self)
    }
    
    
    
    
}
