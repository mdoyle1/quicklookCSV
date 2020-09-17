//
//  Sorting.swift
//  quicklookCSV
//
//  Created by developer on 5/27/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//


import Foundation
import SwiftUI


func pasteSearch(control:ControlCenter, array: inout [String], searchText: String, completion: @escaping () -> ()){
   // control.showInitialList = false
    control.searchTerm = searchText
    
    
    if control.selectedHeaders == [] {
        if control.isCaseSensitive{
            array = control.initialList.filter {
                ($0.contains(searchText))}
            control.arrayCount=array.count
            print(array.count)} else {
            array = control.initialList.filter {
                ($0.localizedCaseInsensitiveContains(searchText))}
            control.arrayCount=array.count
            print(array.count)
        }
        
        
    }else {
        
        if control.isCaseSensitive{
            array = control.modifiedList.filter {
                ($0.contains(searchText))}
            control.arrayCount=array.count
            print(control.arrayCount)} else {
            array = control.modifiedList.filter {
                ($0.localizedCaseInsensitiveContains(searchText))}
            control.arrayCount=array.count
            print(control.arrayCount)
        }
    }
    
    
    completion()
}


//MARK: - SORT ITEMS SORTS CSVARRAY >> SORTED = SORTITEMS()
func sortItems(control: ControlCenter) ->[[(key: String, value: String)]]{
    var dict:[[(key: String, value: String)]] = [[]]
    for item in control.csvArray {
        dict.append(item.sorted(by:{$0.key.lowercased() < $1.key.lowercased()}))
    }
    return dict
}

//THE INITIAL SORTER...
func sortedItems(control:ControlCenter){
    control.initialList.removeAll()
    for item in control.initialTuple {
        var items = ""
        for (key,value) in item {
            for header in control.headers {
                if header == key {
                    let item = key.trimmingCharacters(in: .whitespacesAndNewlines) + ":  " + value.trimmingCharacters(in: .whitespacesAndNewlines) + "\n"
                    items+=item
                }
            }
           // print(key,value)
        }
        if items == "" {
            print("empty item")
        }else{
        control.initialList.append(items)
        //control.modifiedList.append(items)
        print("")
        }
    }
}



//UPDATE THE HEADERS OFTHE INITIAL SORTER...
//UPDATE Initial List
func changeHeaderNamesSortedItems(control:ControlCenter, completion: @escaping () -> ()){
    control.initialList.removeAll()
    control.modifiedList.removeAll()
    control.loadingText = "Updating Content..."
    control.loading = true
    DispatchQueue.main.async {
  
    for item in control.initialTuple {
        var items = ""
        for (key,value) in item {
                for updateHeader in control.updatedHeaderNames {
                        if updateHeader.key == key {
                            let item = updateHeader.value.trimmingCharacters(in: .whitespacesAndNewlines) + ":  " + value.trimmingCharacters(in: .whitespacesAndNewlines) + "\n"
                    items+=item
                }
            }
           // print(key,value)
        }
        if items == "" {
            print("empty item")
        }else{
        control.initialList.append(items)
        control.modifiedList.append(items)
        print("")
        }
    }
    completion()
    }
}


//SORTS SELECTED Modified HEADERS
func sortedSelectedModifiedHeaders(control:ControlCenter, completion: @escaping () -> ()){
control.loading = true
control.loadingText = "Updating Content..."
print("MODFIEDHEADERS SELECTED")
    DispatchQueue.main.async {

    
    control.modifiedList.removeAll()
    print("SORTED SELECTED ITEMS")
        
    //INITIALTUPLE WILL RETAIN ORIGINAL HEADERS
    for item in control.initialTuple {
        var items = ""
        for (key,value) in item {
            //SELECTEDHEADERS IS ALWAYS UPDATED WHEN HEADERS ARE MODIFIED
            for header in control.selectedHeaders {
                //UPDATEDHEADERNAMES KEYS WILL STORE ORIGINAL KEY VALUES, THE VALUE OF UPDATED HEADER NAMES HAS THE UPDATED HEADERS.
                for modifiedHeader in control.updatedHeaderNames{
                    //THIS WILL WORK FOR ITEMS THAT DON'T HAVE MODIFIED HEADERS
                    if header == key  && header == modifiedHeader.key {
                        let item = modifiedHeader.value.trimmingCharacters(in: .whitespacesAndNewlines) + ":  " + value.trimmingCharacters(in: .whitespacesAndNewlines) + "\n"
                    items+=item
                    }
                    //THIS WILL WORK FOR MODIFIED HEADER ITEMS
                    else if modifiedHeader.key != header && modifiedHeader.value == header && modifiedHeader.key == key{
                         let item = modifiedHeader.value.trimmingCharacters(in: .whitespacesAndNewlines) + ":  " + value.trimmingCharacters(in: .whitespacesAndNewlines) + "\n"
                        items+=item
                    }
                }
            }
        }
        if items == "" {
            print("empty")
        }else{
            control.modifiedList.append(items)
        }
    }
    completion()
    }
}


//SORTS SELECTED HEADERS
func sortedSelectedItems(control:ControlCenter, completion: @escaping () -> ()){
    control.modifiedList.removeAll()
    print("SORTED SELECTED ITEMS")
    print("SORTEDSLECTEDITEMS")
    for item in control.initialTuple {
        var items = ""
        for (key,value) in item {
            for header in control.updatedHeaderNames {
                
                if header.key == key {
                    let item = header.value.trimmingCharacters(in: .whitespacesAndNewlines) + ":  " + value.trimmingCharacters(in: .whitespacesAndNewlines) + "\n"
                    items+=item
                }
            }
        }
        if items == "" {
            print("empty")
        }else{
          
            control.modifiedList.append(items)
        }
    }
}

//EXPORTS ALL ITEMS WITH SELECTED HEADERS ONLY
func exportSelections(control: ControlCenter){
    for item in control.csvArray {
        for (key, value) in item {
            for header in control.selectedHeaders{
                if key == header {
                    print("\(key): \(value)")
                }
            }
        }
    }  }


func buildHeaderList(header: String, control: ControlCenter, completion: @escaping () -> ()){
    if control.selectedHeaders.contains(header){
        
        control.selectedHeaders.removeAll{ $0 == header }
   
    } else {control.selectedHeaders.append(header)
        
    }
    print(control.selectedHeaders)
}




func resetHeaders(control: ControlCenter){
    control.headers.removeAll()
    for item in control.updatedHeaderNames {
        let key = item.key
        control.updatedHeaderNames[item.key] = key
        control.headers.append(key)
        
    }
    print(control.headers)
    print(control.updatedHeaderNames)
}

func pullReset(text: inout String, array: inout [String], control:ControlCenter){
    text = ""
    array = []
    control.searchTerm = ""
    //self.controlCenter.selectedHeaders.removeAll()
    control.ShowStateArray = false
    control.showInitialList = true
   control.arrayCount = control.initialList.count
    //print(control.modifiedList.count)
    array.removeAll()
//    if control.modifiedList.count == 0 {
//        array = control.initialList
//    }else {
//        array = control.initialList}
//    
}
//func keyValueItem(control: ControlCenter){
//    let string = control.currentItem
//    let keyValue = control.currentItem
//    var key = ""
//    var value = ""
//    key = keyValue.components(separatedBy: ":")[0]
//   // value = keyValue.components(separatedBy: ":")[1]
//    print("Here is your key \(key)")
//    print("Here is your value \(value)")
//    control.itemArray = string.components(separatedBy: "\n")
//    print(control.itemArray[0])
//}



func sortHeaders(control:ControlCenter){
    for x in 0..<control.headers.count {
        for item in control.updatedHeaderNames {
            if item.key == control.headers[x] {
                //UPDATE MAIN HEADERS ARRAY
                control.headers[x] = control.updatedHeaderNames[item.key] ?? ""
                //UPDATE HEADER ROW FOR CSV
                control.headerRow+="\(item.value.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\"", with: "\\")),"
            } else if item.value == control.headers[x]{
                //THIS SECTION OCCURES IF A HEADER HAS BEEN CHANGED. THE ITEM VALUE WITH BE THE MODIFIED HEADER.
                control.headers[x] = control.updatedHeaderNames[item.key] ?? ""
                control.headerRow+="\(item.value.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\"", with: "\\")),"
            }
        }
    }
}
