//
//  CSVaccessability.swift
//  quicklookCSV
//
//  Created by developer on 5/27/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import Foundation
import SwiftCSV


var csvData:[[String]]!
var formatedList:[String] = []


func csvToList(control: ControlCenter, completion: @escaping () -> ()){
    
     DispatchQueue.main.async {
        print("Running CSV to LIST on \(String(describing: control.globalPathToCsv))")
        
        
        if let path = control.globalPathToCsv {
            do {
                let text = try String(contentsOfFile: path.absoluteString, encoding: String.Encoding.utf8)
                print(text)
            } catch {
                print("Failed to read text from \(path)")
            }
        } else {
            print("Failed to load file from app bundle.")
        }
        
        
        
    if let url = control.globalPathToCsv {
        do {
            print(url)
            let csvFile: CSV = try CSV(
                 url: control.globalPathToCsv,
                 delimiter: ",",
                 encoding: .utf8,
                 loadColumns: false
            )
            let csv = csvFile
            control.headers = csv.header

            //CREATE UPDATEDHEADERNAMES DICTIONARY FOR STORING ORIGINAL HEADER NAMES AND MODIFYING
            for header in control.headers {
                control.updatedHeaderNames[header]=header
                control.AddItem[header]=""
            }
            //ORIGINAL HEADERS IS USED TO RESET HEADER LIST IF MODIFIED
            control.originalHeaders = csv.header
            control.csvArray = csv.namedRows
            
           print(control.headers)
          // print(control.csvArray[0][control.headers[0]] as Any)
            
        } catch {print("contents could not be loaded")}
    }
    else {print("the URL was bad!")}
        control.showLists = true
        control.initialTuple = sortItems(control: control)
        sortedItems(control: control)
        control.loading = false
        control.listIsLoaded = true
        control.arrayCount=control.initialList.count
        print("HERE IS YOUR INITIAL TUPLE COUNT \(control.initialTuple.count)")
        completion()
    }
   
}


