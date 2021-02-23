//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Viktor Golubenkov on 26.10.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    
    let photoInfoController = PhotoInfoController()

    override func viewDidLoad() {
        super.viewDidLoad()
 
        descriptionLabel.text = ""
        copyrightLabel.text = ""
   
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
                self.updteUI(with: photoInfo)
            }
        }
        
}
    
    func updteUI(with photoInfo: PhotoInfo) {
        guard let url = photoInfo.url.withHTTPS() else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                   
                    self.title = photoInfo.title
                    self.descriptionLabel.text = photoInfo.description
                    
                    if let copyright = photoInfo.copyright {
                        self.copyrightLabel.text = "© \(copyright)"
                    } else {
                        self.copyrightLabel.isHidden = true
                    }
                    self.imageOutlet.image = image
                }
            }
        }
        task.resume()
    }

    
}

