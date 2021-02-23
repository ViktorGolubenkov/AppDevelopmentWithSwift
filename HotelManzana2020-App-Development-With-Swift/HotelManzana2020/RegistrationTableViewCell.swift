//
//  RegistrationTableViewCell.swift
//  HotelManzana2020
//
//  Created by Viktor Golubenkov on 11.10.2020.
//

import UIKit

class RegistrationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  
}
