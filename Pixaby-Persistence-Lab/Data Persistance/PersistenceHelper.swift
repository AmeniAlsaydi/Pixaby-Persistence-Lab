//
//  PersistenceHelper.swift
//  Pixaby-Persistence-Lab
//
//  Created by Amy Alsaydi on 1/20/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation

enum DataPersiatanceError: Error { // conforming to the Error protocol
    case savingError(Error) // associative value
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)

}

class PersistenceHelper {
    // CRUD - create, read, update, delete
    
    // array of photos
    private static var favorites = [Photo]()
    private static var fileName = "favorites.plist"
    
    private static func save() throws {
           
           // get url path to file the photo will be saved to
           
           let url = FileManager.pathDocumentsDirectory(with: fileName)
           
           // photos array will be object being converted to data
           // we will use Data object and write (save) it to documents direcotry
           
           do {
               // convert (serialize) photos array to Date
               let data = try PropertyListEncoder().encode(favorites)
               try data.write(to: url, options: .atomic)
               // atomic
           } catch {
               // the view controller that uses the save function ^^^
               throw DataPersiatanceError.savingError(error)
               
           }
           
       }
    
    // create - save item to documents directory
    
    static func create(photo: Photo) throws { // mark our function as a throwing
        
        // append new photo to the photos array
        favorites.append(photo)
        do {
             try save()
        } catch {
            throw DataPersiatanceError.savingError(error)
        }
    }
    
    // read - load (retrieve) items from documents directory
    
    static func loadFavorites() throws -> [Photo] {
        let url = FileManager.pathDocumentsDirectory(with: fileName)
        
        //check if file exist
        // to convert url to string we use .path on the URL
        
        
        if FileManager.default.fileExists(atPath: url.path) {
            
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    let search = try PropertyListDecoder().decode(PhotoSearch.self, from: data)
                    favorites = search.hits
                    
                } catch {
                    throw DataPersiatanceError.decodingError(error)
                    
                }
            } else {
                throw DataPersiatanceError.noData
            }
        } else {
            throw DataPersiatanceError.fileDoesNotExist(fileName)
        }
        return favorites
    }
    
    // update -
    
    // delete - remove item from documents directory
    
    static func delete(photoAt index: Int) throws {
        
        favorites.remove(at: index)
        
        // save our photos array to the documents directory
        do {
           try save()
        } catch {
            throw DataPersiatanceError.deletingError(error)
        }
        
        
    }
}
