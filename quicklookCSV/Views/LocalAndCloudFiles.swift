//
//  LocalAndCloudFiles.swift
//  quicklookCSV
//
//  Created by developer on 6/11/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI
import SwiftUIRefresh

var fileName:String = ""

struct LocalAndCloudFiles: View {
    @EnvironmentObject var controlCenter:ControlCenter
    @State var cloudFile:Bool = true
    @State var array:[String] = []
    @State var text:String = ""
    @State private var isShowing = false
    @State var shouldPopToRoot = false
    @ObservedObject var connectivityProvider: ViewModel = ViewModel(connectivityProvider: ConnectivityProvider())
    
    func removeItems(at offsets: IndexSet){
        let itemIndex:Int = offsets.first!
        print(controlCenter.urlFileNames[itemIndex])
        do { try FileManager.default.removeItem(at: controlCenter.urlFileNames[itemIndex].url) } catch { print("unable to delete file")}
        controlCenter.urlFileNames.remove(at:itemIndex)
    }

   
    
    var body: some View {
        
        VStack{
            if self.controlCenter.showHelp == true {
                Help()
            } else {
                FileSearchBar(text: $text)
                List {
                  
                    ForEach(controlCenter.urlFileNames.sorted(by: { $0.file.lowercased() < $1.file.lowercased()})) { indx in
                    
                        if indx.file.lowercased().contains(text.lowercased()) || text == ""{
                        NavigationLink(destination:CSVList().onAppear{
                            //IF THE ITEM IS NOT IN THE CLOUD...
                            if indx.cloud == false {
                                self.controlCenter.globalPathToCsv = indx.url
                                self.controlCenter.showLists = true
                                self.controlCenter.fileName = indx.file
                                fileName = indx.file
                                //connectivityProvider.sendName()
                            }
                                //OTHERWISE THE ITEM IS IN THE CLOUD...
                            else{
                                print("The item is in the cloud.")
                                self.controlCenter.cloudFile = true
                                self.controlCenter.loading = true
                                downloadCloudFile(control: self.controlCenter, fileURL: indx.url, completion: {
                                    print("Fetch Files")})
                                
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
            array = listOfFileNames
        self.controlCenter.urlFileNames = self.controlCenter.urlFileNames.sorted(by: { $0.file.lowercased() < $1.file.lowercased()})
        }
        //.resignKeyboardOnDragGesture()
    }
}



