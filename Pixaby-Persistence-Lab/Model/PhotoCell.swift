//
//  PhotoCell.swift
//  Pixaby-Persistence-Lab
//
//  Created by Amy Alsaydi on 1/20/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import ImageKit

class PhotoCell: UICollectionViewCell {
    
     @IBOutlet weak var photoImageView: UIImageView!
    
    public func configureCell(with photoUrl: String) {
        photoImageView.getImage(with: photoUrl) { (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self.photoImageView.image = UIImage(systemName: "exclamationmark-triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.photoImageView.image = image
                }
            }
        }
    }
}
