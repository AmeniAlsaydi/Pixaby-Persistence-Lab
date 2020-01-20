//
//  DetailViewController.swift
//  Pixaby-Persistence-Lab
//
//  Created by Amy Alsaydi on 1/20/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    var photo: Photo?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    override func viewWillLayoutSubviews() {
        photoImageView.layer.cornerRadius = photoImageView.frame.width/20
    }
    
    
    
    func updateUI() {
        guard let photo = photo else {
            fatalError("no photo check segue")
        }
        userLabel.text = "User: \(photo.user)"
        
        photoImageView.getImage(with: photo.largeImageURL) { (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self.photoImageView.image = UIImage(systemName: "exclamationmark-triangle")                }
            case .success(let image):
                DispatchQueue.main.async {
                self.photoImageView.image = image
                }
            }
        }
        
        
    }
    

}
