//
//  ImportExport.swift
//  quicklookCSV
//
//  Created by developer on 6/4/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import Foundation
import SwiftUI

//GETS FILES IN THE DOCUMENTS FOLDER
func getFiles(control: ControlCenter, completion: @escaping () -> ()){
    
    control.urlFileNames.removeAll()
    control.recentFiles.removeAll()

    do {
        let fileURLs = try FileManager.default.contentsOfDirectory(at:  CloudDataManager.getDocumentDiretoryURL(), includingPropertiesForKeys: nil)
        //URLS ARE STORED HERE
        control.recentFiles.append(contentsOf: fileURLs)
        print(fileURLs)
    } catch {
        print("Error while enumerating files \(CloudDataManager.getDocumentDiretoryURL()): \(error.localizedDescription)")
    }
    
    for item in control.recentFiles {
        let file = item.lastPathComponent
        
        print("APPENDING TO RECENT FILES")
        if file == "" {print("Blank Item")}else{
            if file[file.index(file.startIndex, offsetBy:0)] != "." {
                control.urlFileNames.append(LocalCloudFiles(url: item, file: item.lastPathComponent, cloud: false))
            }else{
                control.urlFileNames.append(LocalCloudFiles(url: item, file: item.lastPathComponent, cloud: true))
                print(item.lastPathComponent)
                
            }
        }
        
    }
    //  control.urlFileNames = control.urlFileNames.sorted {$0.file < $1.file}
    print(control.urlFileNames)
    
}


//DELETE FILES
func deleteFiles(control: ControlCenter){

    do {
        let fileURLs = try FileManager.default.contentsOfDirectory(at: CloudDataManager.getDocumentDiretoryURL(), includingPropertiesForKeys: nil)
        control.recentFiles.append(contentsOf: fileURLs)
        print(fileURLs)
    } catch {
        print("Error while enumerating files \(CloudDataManager.getDocumentDiretoryURL()): \(error.localizedDescription)")
    }
    
}

//FUNCTIONS TO GET AND WRITE FILES
func getDocumentsDirectory() -> URL {

    do{
        try FileManager.default.createDirectory(at: CloudDataManager.getDocumentDiretoryURL(), withIntermediateDirectories: true, attributes: nil)
    }catch{print("FUCK IN A")}

    return CloudDataManager.getDocumentDiretoryURL()
}

func writeDataToFile(file:String, row:String){
    let str = row
    let filename = CloudDataManager.getDocumentDiretoryURL().appendingPathComponent(file)
    do {
        try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
    } catch {
        print("failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding")
    }
}


//GET CONTENTS OF FILE AND CREATE A NEW FILE IN DOCUMENTS FOLDER.
func importItems(control:ControlCenter, filename: String, completion: @escaping () -> ()){
    var csv = ""
    var headerRow = ""
    
    csvToList(control: control, completion: {control.loading = false})
    //BUILD THE CSV
    for header in control.headers.sorted() {
        headerRow+="\(header),"
    }
    csv.append("\(headerRow.dropLast())\n")
    print(csv)
    
    for item in control.initialTuple {
        var items = ""
        for (key,value) in item {
            for header in control.selectedHeaders {
                if header == key {
                    let item = "\(value),"
                    items+=item
                    print(item)
                }
            }
        }
        items = "\(items.dropLast())\n"
        if items == "" {
            print("empty")
        }else{
            csv.append(items)}
    }
    
    //WRITE DATA TO SPECIFIED FILE...
    writeDataToFile(file: "\(filename)", row: csv)
    print(csv)
}



func exportOrCompressCSV(control:ControlCenter, exportFile:Bool, filterString: String, fileName: String, completion: @escaping () -> ()){
    
    control.loading = true
    print("Initial Tuple Count = \(control.initialTuple.count)")
    
    if exportFile{
        control.loadingText = "Exporting Data..."
        print("Add headers to the top of the list...")}
        
    else { control.loadingText = "Compressing Data..."}
    
    var csv = String()
    var headerRow = String()
    
    print("Current Search Term \(filterString)")
    print("INITIAL TUPLE COUNT \(control.initialTuple.count)")
    print("MODIFIED TUPLE COUNT \(control.modifiedTuple.count)")
    print("Here is your filterString \(filterString)")
    var filtered:[[(key: String, value: String)]] = []
    
    
    
    for x in 0..<control.headers.count {
        for item in control.updatedHeaderNames {
            if item.key == control.headers[x]{
                control.headers[x] = item.value
            } else if item.value == control.headers[x] {
                control.headers[x] = item.value
            }
            for indx in 0..<control.selectedHeaders.count {
                if control.selectedHeaders[indx] == item.key {
                    control.selectedHeaders[indx] = item.value
                }
            }
            
        }
    }
    
    
    //MARK: -IF NO HEADERS ARE SELECTED
    print("Selected Headers Count \(control.selectedHeaders.count)")
    if control.selectedHeaders.count == 0 {
        
        print("for header in control.updatedHeaderNames.sorted(by: { $0.key < $1.key }) {")
        for header in control.updatedHeaderNames.sorted(by: { $0.key < $1.key }) {
            for item in control.headers {
                if item == header.value {
                    headerRow+="\(header.value.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\"", with: "\\")),"
                }
            }
        }
        
        if control.searchTerm != "" {
            print("HERE ARE YOUR CURRENT HEADERS \(control.headers)")
            
            for item in control.initialTuple {
                print(item)
                
                if control.isCaseSensitive {
                    if item.contains(where: ({$0.value.contains(control.searchTerm)})){
                        filtered.append(item.sorted(by: { $0.key < $1.key }))}}else {
                    if item.contains(where: ({$0.value.localizedCaseInsensitiveContains(control.searchTerm.lowercased())})){
                        filtered.append(item.sorted(by: { $0.key < $1.key }))}
                }
                
            }
            //SET THE INITIAL TUPLE FOR NO HEADERS SELECTED EXPORT
            control.initialTuple.removeAll()
            control.initialTuple = filtered
            print("FIRST FILTER: Search")
            print("initialTuple count \(control.initialTuple.count)")
            print("filtered count \(filtered.count)")
        }
        
        
        print("PPP\(control.initialTuple.count)")
        
        
    } else {
        print("items filtered.")
    }
    
    
    
    
    
    
    //MARK: - IF HEADERS ARE SELECTED
    if control.selectedHeaders.count != 0 {
        
        for header in control.updatedHeaderNames.sorted(by: { $0.key < $1.key }) {
            for selectedHeader in control.selectedHeaders {
                if selectedHeader == header.value {
                    headerRow+="\(header.value.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\"", with: "\\")),"
                }
            }
        }
        
        
        //FILTER THE INITIAL TUPLE WITH WHAT EVER IS IN THE SEARCH TERM.
        if control.searchTerm != "" {
            for modifiedHeader in control.updatedHeaderNames.sorted(by: { $0.key < $1.key }) {
                for header in control.selectedHeaders {
                    for item in control.initialTuple {
                        if modifiedHeader.value == header {
                            if control.isCaseSensitive {
                                if item.contains(where: ({$0.key == modifiedHeader.key && $0.value.contains(control.searchTerm)})){
                                    filtered.append(item.sorted(by: { $0.key < $1.key }))
                                    print(item)
                                }}
                            else {
                                if item.contains(where: ({$0.key == modifiedHeader.key && $0.value.localizedCaseInsensitiveContains(control.searchTerm.lowercased())})){
                                    filtered.append(item.sorted(by: { $0.key < $1.key }))
                                    print(item)
                                }
                            }
                        }
                    }
                    
                }
            }
            print(control.searchTerm)
            print("Initial Tuple Count: Ohio \(control.initialTuple.count)")
            print("Filtered Count \(filtered)")
            control.initialTuple.removeAll()
            control.initialTuple = filtered
            
        } else {
            //SET INITIAL TUPLE FOR SELECTED HEADER EXPORT
            for modifiedHeader in control.updatedHeaderNames.sorted(by: { $0.key < $1.key }) {
                for header in control.selectedHeaders {
                    for item in control.initialTuple {
                        if modifiedHeader.value == header {
                            if item.contains(where: ({$0.key == modifiedHeader.key})){
                                filtered.append(item)
                            }
                        }
                    }
                }
            }
            control.initialTuple.removeAll()
            control.initialTuple = control.modifiedTuple
        }
        print("SECOND FILTER")
    }
    
    //SET THE INITIAL LIST TO THE MODIFIED LIST....
    if control.selectedHeaders != [] {
        control.initialList = control.modifiedList }
    else { print("List remains.") }
    
    //MARK:- BUILD THE CSV
    if exportFile {
        print("her eis your header row")
        print(headerRow)
        
        
        control.loading = true
        control.loadingText = "Exporting Content..."
        print("Building CSV")
        print("Exporing From InitialTuple")
        
        //BUILD EMPTY ELEMENT TO COMAPARE APPENDING ITEMS TO, SO THERE ARE NO BLANK LINES IN CSV.
        var empty = ""
        if control.selectedHeaders != [] {
            for modifiedHeader in control.updatedHeaderNames.sorted(by: { $0.key < $1.key }){
                for header in control.selectedHeaders.sorted() {
                    if modifiedHeader.value == header {
                        empty += "\"\","
                    }
                }
            }
        }
        else {
            for modifiedHeader in control.updatedHeaderNames.sorted(by: { $0.key < $1.key }){
                for header in control.headers.sorted() {
                    if modifiedHeader.value == header {
                        empty += "\"\","
                        print("empty object no selected headers")
                    }
                }
            }
        }
        

        
        //MARK: - WRITE ITEMS
        print("Counts")
        print(control.initialTuple.count)
        print(control.modifiedTuple.count)
        
        for item in control.initialTuple {
            print("Z FUCK \(control.initialTuple.count)")
            var items:String = String()
            print(item)
            for (key, value) in item {
                
                var z = 0
                for x in 0..<item.count {
                    z+=item[x].value.count
                }
                if z == 0 {
                    print("Blank")
                    items+="\"\","
                }else{
                    print("Total Headers \(item.count)")
                    if control.selectedHeaders != [] {
                        print("Selected Headers \(headerRow)")
                        //USE UPDATED HEADER NAMES DICT SINCE TUPLE KEYS STILL ARE ORIGINAL
                        for header in control.updatedHeaderNames.sorted(by: { $0.key < $1.key }) {
                            if header.key == key {
                                for selectedHeader in control.selectedHeaders.sorted() {
                                    if selectedHeader == header.value {
                                        if value.first == "\""{
                                            var object = "\(value.trimmingCharacters(in: .whitespacesAndNewlines)),"
                                            if object.contains(where: { $0 == "\"" }){
                                                object = object.replacingOccurrences(of: "\"", with: "\'\'")
                                            }
                                            items+=object
                                            print("Appending Key Zipto: \(key) : \(object)")
                                        }else {
                                            let object = "\"\(value.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\"", with: "\'\'"))\","
                                            items+=object
                                            print("Appending Key: \(key) : \(object)")
                                        }
                                    }
                                }
                            }
                        }
                    }else {
                        
                        
                        print("No headers are selected.")
                        for header in control.updatedHeaderNames.sorted(by: { $0.key < $1.key }) {
                            for mainHeader in control.headers.sorted() {
                                if mainHeader == header.value {
                                    if key == header.key {
                                        if value.first == "\""{
                                            let object = "\(value.trimmingCharacters(in: .whitespacesAndNewlines)),"
                                            items+=object
                                            print("Appending \(key): \(object)")
                                        }
                                        else {
                                            let object = "\"\(value.trimmingCharacters(in: .whitespacesAndNewlines))\","
                                            
                                            items+=object
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            print(items)
            if items != empty && items.count != 0 {
                print("Item Count \(items.count)")
                print(item.description)
                items = "\(items.dropLast())\n"
                csv.append(items)}
        }
    print("New York")
       print(csv)
             //MARK: - WRITE HEADER ROW
        let headtop = headerRow.replacingOccurrences(of: "\n", with: "\\")
               let contents = "\(headtop.dropLast() + "\n" + csv)"
               print("Sacko")
               print(contents)
               writeDataToFile(file: fileName, row: contents)
        
    }
    completion()
}


//FILENAME

struct FileNameTitle:View{
    @EnvironmentObject var controlCenter:ControlCenter
    var body: some View {
        HStack{
            Text(self.controlCenter.fileName)
                .font(.headline)
                .padding(.all, 4)}
    }
}



func downloadCloudFiles (control: ControlCenter, completion: @escaping () -> ()){
    // Here select the file url you are interested in (for the exemple we take the first)
    for url in control.recentFiles {
        // We have our url
        var isDownloaded = false
        var lastPathComponent = url.lastPathComponent
        if lastPathComponent.contains(".icloud") {
            // Delete the "." which is at the beginning of the file name
            lastPathComponent.removeFirst()
            let folderPath = url.deletingLastPathComponent().path
            let downloadedFilePath = folderPath + "/" + lastPathComponent.replacingOccurrences(of: ".icloud", with: "")
            do {
                try FileManager.default.startDownloadingUbiquitousItem(at: url)
            } catch {
                print("Unexpected error: \(error).")
            }
            while !isDownloaded {
                if FileManager.default.fileExists(atPath: downloadedFilePath) {
                    
                    isDownloaded = true
                    print("Downloaded File")
                    
                }
            }
            // Do what you want with your downloaded file at path contains in variable "downloadedFilePath"
        }
        
    }
    completion()
}

func downloadFile(control: ControlCenter, url: URL, completion: @escaping () -> ()) {
    do {
        try FileManager.default.startDownloadingUbiquitousItem(at: url)
        // getFiles(control: control, completion: {print("gotfile")})
        completion()
    }  catch {
        print("Unexpected error: \(error).")
    }
    
}

func downloadCloudFile (control: ControlCenter, fileURL: URL, completion: @escaping () -> ()){
    
    
    
    let lastPathComponent = fileURL.lastPathComponent
    let fileName =  lastPathComponent.replacingOccurrences(of: ".icloud", with: "").dropFirst()
    control.loadingText = "Fetching \(fileName)"
    control.loading = true
    if lastPathComponent.contains(".icloud") {
        // Delete the "." which is at the beginning of the file name
        
        // let fileName =  lastPathComponent.replacingOccurrences(of: ".icloud", with: "").dropFirst()
        
        print("HERE IS YOUR FILE \(fileName)")
        let folderPath = fileURL.deletingLastPathComponent().path.replacingOccurrences(of: " ", with: "%20")
        print("HERE IS THE FOLDERPATH \(folderPath)")
        let downloadedFilePath = "file://"+folderPath + "/" + fileName
        print("HERE IS YOUR FILE PATH \(downloadedFilePath)")
        control.globalPathToCsv = URL(string:downloadedFilePath)
        
        downloadFile(control: control, url: fileURL, completion: {
            if FileManager.default.fileExists(atPath: downloadedFilePath) {
                
                print("Downloaded File")
                print(downloadedFilePath)
                
            }
        })
        
    }
    completion()
    
}


extension FileManager {

    open func secureCopyItem(at srcURL: URL, to dstURL: URL) -> Bool {
        do {
            if FileManager.default.fileExists(atPath: dstURL.path) {
                try FileManager.default.removeItem(at: dstURL)
            }
            try FileManager.default.copyItem(at: srcURL, to: dstURL)
        } catch (let error) {
            print("Cannot copy item at \(srcURL) to \(dstURL): \(error)")
            return false
        }
        return true
    }

}
