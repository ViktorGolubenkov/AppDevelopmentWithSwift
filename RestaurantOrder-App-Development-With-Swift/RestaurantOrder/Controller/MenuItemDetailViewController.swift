//
//  MenuItemDetailViewController.swift
//  RestaurantOrder
//
//  Created by Viktor Golubenkov on 30.10.2020.
//

import UIKit


class MenuItemDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailTextLabel: UILabel!
    @IBOutlet weak var addToOrderButton: UIButton!
    
    var menuItem: MenuItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        addToOrderButton.layer.cornerRadius = 15.0
        updateUI()
    }
    
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        guard let menuItem = menuItem else { return }
        coder.encode(menuItem.id, forKey: "menuItemId")
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        let menuItemID = Int(coder.decodeInt32(forKey: "menuItemId"))
        menuItem = MenuController.shared.item(withID: menuItemID)!
        updateUI()
    }
    
    
    func updateUI() {
        guard let menuItem = menuItem else { return }
        
        titleLabel.text = menuItem.name
        priceLabel.text = String(format: "$%.2F", menuItem.price)
        detailTextLabel.text = menuItem.detailText
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }

    @IBAction func addToOrderButtonTapped(_ sender: Any) {
        guard let menuItem = menuItem else { return }
        UIView.animate(withDuration: 0.3) {
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
        // badge "!" when something added to cart
        self.tabBarController?.increaseBadge(indexOfTab: 1, num: "!")
        
        MenuController.shared.order.menuItems.append(menuItem)
    }

}
