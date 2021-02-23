//
//  OrderConfirmationViewController.swift
//  RestaurantOrder
//
//  Created by Viktor Golubenkov on 06.11.2020.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var finishOrderButton: UIButton!
    
    var minutes: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishOrderButton.layer.cornerRadius = 15.0
        
        let sLetter = minutes! == 1 ? "" : "s"

        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!) minute\(sLetter)."
    }
    
    @IBAction func finishOrderButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.finishOrderButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.finishOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }

}
