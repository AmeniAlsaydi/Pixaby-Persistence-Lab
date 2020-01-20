//
//  PhotosApiClient.swift
//  Pixaby-Persistence-Lab
//
//  Created by Amy Alsaydi on 1/20/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation
import NetworkHelper

struct PhotoApiClient {
    static func getPhotos(searchQuery: String, completion: @escaping (Result<[Photo], AppError>)-> ()) {
        
        let endpoint = "https://pixabay.com/api/?key=\(Secrets.apiKey)=\(searchQuery)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                // network error
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    // parse data
                    let results = try JSONDecoder().decode(PhotoSearch.self, from: data)
                    let photos = results.hits
                    completion(.success(photos))
                    
                } catch {
                    // decoding error
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
}
