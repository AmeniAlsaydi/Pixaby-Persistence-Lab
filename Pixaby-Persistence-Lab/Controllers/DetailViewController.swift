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
    @IBOutlet weak var favoriteButton: UIButton!
    
    var photo: Photo?
    var buttonTag: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        print(FileManager.getDocumentsDirectory())

    }
    
    override func viewWillLayoutSubviews() {
        photoImageView.layer.cornerRadius = photoImageView.frame.width/20
    }
    
    
    func updateUI() {
        guard let photo = photo, let buttontag = buttonTag else {
            fatalError("no photo or no button tag check segue")
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
        
        if buttontag == 2 {
            let heartImage = UIImage(systemName: "heart.fill")
            favoriteButton.setImage(heartImage, for: .normal)
            favoriteButton.isEnabled = false
        }
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        
        guard let photo = photo else {
            fatalError("no photo check segue")
        }
        
        // change to filled heart:
        
        let heartImage = UIImage(systemName: "heart.fill")
        favoriteButton.setImage(heartImage, for: .normal)
        sender.isEnabled = false
        
        // save/persist photo
        
        do {
            try PersistenceHelper.create(photo: photo)
        } catch {
            print("error saving event with error: \(error)")
        }
        
    }
    

}
