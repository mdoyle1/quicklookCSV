//
//  DataManager.swift
//  quicklookCSV
//
//  Created by developer on 6/6/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import Foundation
import SwiftUI
//https://stackoverflow.com/questions/30385940/why-my-app-is-not-shown-in-icloud-drive-folder
//https://stackoverflow.com/questions/33886846/best-way-to-use-icloud-documents-storage
//https://theswiftdev.com/how-to-use-icloud-drive-documents/


var containerUrl: URL? {
         return FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents")
     }

class CloudDataManager {
    
    class func getDocumentDiretoryURL() -> URL {
        
        let localDocumentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let iCouldDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents")
        
       if let url = containerUrl, !FileManager.default.fileExists(atPath: url.path, isDirectory: nil) {
                   do {
                       try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                   }
                   catch {
                       print(error.localizedDescription)
                   }
               }
  
  
        return iCouldDocumentsURL ?? localDocumentsURL
    }
}
