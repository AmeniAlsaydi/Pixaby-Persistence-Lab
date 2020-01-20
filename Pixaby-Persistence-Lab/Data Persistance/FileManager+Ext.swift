//
//  FileManager+Ext.swift
//  Pixaby-Persistence-Lab
//
//  Created by Amy Alsaydi on 1/20/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation

extension FileManager {
    // Function gets URL path to documents directory
    // FileManager.getDocumentsDirectory() // type method, called on the type FileManager
    
    static func getDocumentsDirectory() -> URL {
        
        // FileManager has a singleton called default
        // UserDefaults has a singleton called standard
        // .urls is a function that returns an array of urls so we have to use [0]
        // .userDomainMask specific for the app aka user
        
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        
    }
    
    // documents/schedule.plist "schedules.plist"
    static func pathDocumentsDirectory(with filename: String) -> URL {
        // appends the filename to the doc directory url path, but not yet creating it, just geting the path.
        // we use this to write to a specific path, we pass this url
        // .appendingPathComponent :
        return getDocumentsDirectory().appendingPathComponent(filename)
        
    }
}
