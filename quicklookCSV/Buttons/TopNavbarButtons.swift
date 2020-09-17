//
//  Export.swift
//  quicklookCSV
//
//  Created by developer on 5/27/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//


import SwiftUI

struct TopNavbarButtons: View {
    
    @EnvironmentObject var controlCenter: ControlCenter
    @State var shouldPopToRoot:Bool = false
    //THIS IS THE SHARE FUNCTION!
    func exportItems(control:ControlCenter, filterString: String, completion: @escaping () -> ()){
        
        var csv = String()
        print("Add headers to the top of the list...")
        var headerRow = String()
        
        
        var filtered:[[(key: String, value: String)]] = []
        
        if filterString != "" {
            // THIS WILL TAKE THE SEARCH TEXT AND EXPORT THE RESULTS BASED ON YOUR SEARCH...
            for item in control.initialTuple {
                if item.contains(where: {$0.value.lowercased().contains(filterString.lowercased())}){
                    filtered.append(item)
                }
            }
            print(filtered)
        } else {
            filtered = control.initialTuple
        }
        
        //BUILD THE CSV
        for header in control.selectedHeaders.sorted() {
            for modifiedHeader in control.updatedHeaderNames {
                if modifiedHeader.key == header {
                    
                    headerRow+="\(modifiedHeader.value),"
                }
            }
        }
        csv.append("\(headerRow.dropLast())\n")
        print(csv)
        
        for item in filtered {
            var items = ""
            for (key,value) in item {
                for header in control.selectedHeaders {
                    for modifiedHeader in control.updatedHeaderNames {
                        if header == key && header == modifiedHeader.key{
                            let item = "\(value),"
                            items+=item
                        }
                    }
                }
            }
            items = "\(items.dropLast())\n"
            if items == "" {
                print("empty")
            }else{
                csv.append(items)}
        }
        sharedItem = csv
    }
    
    var body: some View {
        
        HStack{
            
            EditButton()
            
            
            if self.controlCenter.itemViewIsShowing == false {
                Button(action:{self.controlCenter.isCaseSensitive.toggle()})
                {if self.controlCenter.isCaseSensitive {
                    Text("A").font(.custom("courier", size: 25)).bold()
                } else {Text("a").font(.custom("courier", size: 25)).bold()}
                }
                
                
                
                //MARK: - COMPRESS LIST
                Button(action:{
                    exportOrCompressCSV(control: self.controlCenter, exportFile: false, filterString: self.controlCenter.searchTerm, fileName: "", completion: {
                        print("compressed")
                        self.controlCenter.loading = false
                        self.controlCenter.showChangeHeaderName = false
                        //SET THE INITIAL LIST
                                            if self.controlCenter.searchTerm.count != 0 {
                                                if self.controlCenter.isCaseSensitive {
                                                    self.controlCenter.initialList = self.controlCenter.initialList.filter {
                                                        self.controlCenter.searchTerm.isEmpty ? true : (($0.contains(self.controlCenter.searchTerm)))
                                                    }
                                                    self.controlCenter.modifiedList = self.controlCenter.initialList.filter {
                                                        self.controlCenter.searchTerm.isEmpty ? true : (($0.contains(self.controlCenter.searchTerm)))}
                                                }
                                                else {
                                                    self.controlCenter.initialList = self.controlCenter.initialList.filter {
                                                        self.controlCenter.searchTerm.isEmpty ? true : (($0.localizedCaseInsensitiveContains(self.controlCenter.searchTerm.lowercased())))
                                                    }
                                                    self.controlCenter.modifiedList = self.controlCenter.initialList.filter {
                                                        self.controlCenter.searchTerm.isEmpty ? true : (($0.localizedCaseInsensitiveContains(self.controlCenter.searchTerm.lowercased())))}
                                                }}

                        
                        
                        //REMOVE UNUSED HEADERS FROM UPDATEDHEADERS AND HEADERS....
                        if self.controlCenter.selectedHeaders != [] {
                          
                    self.controlCenter.headers = self.controlCenter.selectedHeaders
                            self.controlCenter.originalHeaders.removeAll()
                            
                            
                            
                            
            var compressedHeaderNames:Dictionary = Dictionary<String, String>()
                            
                            for header in self.controlCenter.headers {
                                for item in self.controlCenter.updatedHeaderNames {
                                    if item.value == header{
                                        compressedHeaderNames[item.key] = item.value
                                        
                                    }
                                }
                            }
                            self.controlCenter.updatedHeaderNames.removeAll()
                            self.controlCenter.AddItem.removeAll()
                            self.controlCenter.updatedHeaderNames = compressedHeaderNames

                            
                          //REMOVE EXTRAS FROM ORIGINAL ITEMS
                            for item in self.controlCenter.updatedHeaderNames {
                                self.controlCenter.originalHeaders.append(item.key)
                                self.controlCenter.AddItem[item.key] = ""
                            }
                            print("HERE ARE THE UPDATED HEADER NAMES \(self.controlCenter.updatedHeaderNames)")
                        }

                        self.controlCenter.searchTerm = ""
                        self.controlCenter.selectedHeaders.removeAll()
                        print(self.controlCenter.headers)
                        print(self.controlCenter.updatedHeaderNames)
                        // self.controlCenter.headers = self.controlCenter.selectedHeaders
                        print("HERE IS YOUR INITIAL TUPLE COUNT \(self.controlCenter.initialTuple.count)")
                        print("HERE IS YOUR MODIFIED TUPLE COUNT \(self.controlCenter.modifiedTuple.count)")
                        print("HERE IS YOUR ARRAY COUNT \(CSVList().array.count)")
                        
                    })


                }){Image(systemName:"rectangle.compress.vertical")}.padding(.trailing, 8)
            } else {
                Button(action:{
                    if self.controlCenter.itemViewIsShowing == false {
                        self.exportItems(control: self.controlCenter, filterString: self.controlCenter.filteredString, completion: {print("exported data")})
                    }else {
                        sharedItem = self.controlCenter.currentItem
                    }
                    Share().showView()
                }){Image(systemName:"square.and.arrow.up").font(.system(size: 20))}
            }
        }
    }
}


