//
//  LocalAndCloudFiles.swift
//  quicklookCSV
//
//  Created by developer on 6/11/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI
import SwiftUIRefresh

struct LocalAndCloudFiles: View {
    @EnvironmentObject var controlCenter:ControlCenter
    @State var cloudFile:Bool = true
    @State private var isShowing = false
    @State var shouldPopToRoot = false
    
    func removeItems(at offsets: IndexSet){
        let itemIndex:Int = offsets.first!
        print(controlCenter.urlFileNames[itemIndex])
       // controlCenter.recentFiles = controlCenter.recentFiles.sorted(by: {$0.absoluteString < $1.absoluteString} )
        do { try FileManager.default.removeItem(at: controlCenter.urlFileNames[itemIndex].url) } catch { print("unable to delete file")}
        //controlCenter.recentFiles.remove(at: itemIndex)
        controlCenter.urlFileNames.remove(at:itemIndex)
    }

   
    
    var body: some View {
        
        VStack{
            if self.controlCenter.showHelp == true {
                Help()
            } else {
                List {
                    ForEach(controlCenter.urlFileNames.sorted(by: { $0.file.lowercased() < $1.file.lowercased()})) { indx in
                        NavigationLink(destination:CSVList().onAppear{
                            //IF THE ITEM IS NOT IN THE CLOUD...
                            if indx.cloud == false {
                                self.controlCenter.globalPathToCsv = indx.url
                                self.controlCenter.showLists = true
                                self.controlCenter.fileName = indx.file}
                                //OTHERWISE THE ITEM IS IN THE CLOUD...
                            else{
                                print("The item is in the cloud.")
                                self.controlCenter.cloudFile = true
                                self.controlCenter.loading = true
                                
                                
                                downloadCloudFile(control: self.controlCenter, fileURL: indx.url, completion: {
                                    print("Fetch Files")
                                    
                                    //GET FILE AND UPDATE LIST
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        csvToList(control: self.controlCenter, completion: {
                                            self.controlCenter.cloudFile = false
                                            self.controlCenter.headersViewAccessed = false
                                            self.controlCenter.loading = false
                                            self.$controlCenter.searchTerm.wrappedValue = ""
                                            self.controlCenter.arrayCount=self.controlCenter.initialList.count
                                            print(self.controlCenter.arrayCount)
                                            print("FIRST LOAD")})
                                    }
                                })
                                
                            }
                            
                        }){if indx.cloud == false {Button(action:{print("local item")})
                        {HStack{Image(systemName: "circle.fill")
                            Text(indx.file)
                            }
                            }
                        }else {
                            Button(action:{
                                print("item is still in the cloud")
                                
                            }
                            ){HStack{
                                if self.cloudFile{
                                    Image(systemName: "circle")}else{
                                    Image(systemName: "cirlce.fill")
                                }
                                Text(indx.file.dropFirst().replacingOccurrences(of: ".icloud", with: ""))
                                }
                            }
                            }
                        }
                    }.onDelete(perform: self.removeItems)
                    
                }.onAppear{
                    self.controlCenter.cloudFile = false
                }
                .pullToRefresh(isShowing: $isShowing) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        print("Refresh")
                        downloadCloudFiles(control: self.controlCenter, completion: {getFiles(control: self.controlCenter, completion: {print("Fetch Files")})})
                        self.isShowing = false
                        self.controlCenter.urlFileNames = self.controlCenter.urlFileNames.sorted(by: { $0.file.lowercased() < $1.file.lowercased()})
                    }
                  
                }
            }
            
        }.onAppear{
        self.controlCenter.urlFileNames = self.controlCenter.urlFileNames.sorted(by: { $0.file.lowercased() < $1.file.lowercased()})
            resetBools(control:self.controlCenter)
            emptyArrays(control: self.controlCenter)
            initializeItems(control: self.controlCenter)
        }
    }
}



