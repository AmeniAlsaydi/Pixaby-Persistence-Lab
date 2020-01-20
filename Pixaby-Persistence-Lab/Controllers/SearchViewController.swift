//
//  SearchViewController.swift
//  Pixaby-Persistence-Lab
//
//  Created by Amy Alsaydi on 1/20/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    

    var photos = [Photo]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        loadPhotos()

       
    }
    
    func loadPhotos() {
        PhotoApiClient.getPhotos(searchQuery: "fun") { (result) in
            switch result {
            case .failure(let appError):
                print("api client error: \(appError)")
            case .success(let photos):
                self.photos = photos
            }
        }
    }
    

}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            fatalError("could not downcast to custom cell")
        }
        
        let photo = photos[indexPath.row]
        
        cell.configureCell(with: photo.largeImageURL)
        
        return cell
    }
    
    
}
