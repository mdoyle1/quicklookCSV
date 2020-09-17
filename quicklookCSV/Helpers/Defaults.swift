//
//  Defaults.swift
//  quicklookCSV
//
//  Created by developer on 5/29/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import Foundation
import Combine


class Defaults : ObservableObject {
@Published var FilePaths = [[String:String]]()
    @Published var FileNames = [String]()
    

var FilePathsDictionary = UserDefaults.standard.array(forKey: "RecentFiles") as? [[String:String]] ?? [[:]]

    var filename = UserDefaults.standard.array(forKey: "FileNames") as? [String] ?? []
    
var CreateFileDictionary:[String:String] = [:]

    
    
    init(){
        FileNames = filename
        FilePaths = FilePathsDictionary
    }

}


