//
//  ContentView.swift
//  quicklookCSV
//
//  Created by developer on 5/27/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation

//https://www.hackingwithswift.com/books/ios-swiftui/adding-swift-package-dependencies-in-xcode
//https://www.appcoda.com/files-app-integration/
//https://medium.com/@RomainP_design/download-a-file-from-icloud-swift-4-ad074494b8c9

struct ContentView: View {
    
    @EnvironmentObject var controlCenter: ControlCenter
    @ObservedObject var defaults = Defaults()
    @ObservedObject var viewModel:ViewModel
    @ObservedObject var connectivityProvider: ViewModel = ViewModel(connectivityProvider: ConnectivityProvider())
    @State private var loading = true
    @State private var loadingText = "Quicklook"
    @State private var selection:String? = nil
    @State var isActive:Bool = false
    @State var firstTimeView:Bool = true
    
    var fileURLs:[URL] = []
    
    func removeItems(at offsets: IndexSet){
        let itemIndex:Int = offsets.first!
        do { try FileManager.default.removeItem(at: controlCenter.recentFiles[itemIndex]) } catch { print("unable to delete file")}
        controlCenter.recentFiles.remove(at: itemIndex)
        controlCenter.urlFileNames.remove(at:itemIndex)
    }
    
    
    var body: some View {
        NavigationView{
            if self.controlCenter.newFileIsActive == false {
                if self.controlCenter.recentFiles.count != 0 {
                    //MARK: - FILES
                    LocalAndCloudFiles()
                        .onAppear{print("LocalAndCloudFilesView")
                            
                            if firstTimeView {
                            initializeItems(control: self.controlCenter)
                            emptyArrays(control: self.controlCenter)
                            resetBools(control: self.controlCenter)
                            getFiles(control: self.controlCenter,completion: {print("Files Fetched")})
                            }
                            
                            firstTimeView = false
                    }
                    .navigationBarTitle(Text("Recent Files..."), displayMode: .automatic)
                        
                    //MARK: - TOPNAV BAR ITEMS
                    .navigationBarItems(leading:         HStack{
                        ImportButton().padding(.trailing, 10)
                        Button(action: {self.controlCenter.newFileIsActive = true}){Image(systemName: "plus.square").font(.system(size: 20))}.padding(.trailing, 10)
                        
                        Button(action: {
                            viewModel.sendListNames()
                        }){Image(systemName:"applewatch").font(.system(size: 20))}.environmentObject(controlCenter)
                    }, trailing: Logo())
                    
                } else {
                    //MARK: - HELP
                    Help()
                        .navigationBarTitle(Text("Getting Started"), displayMode: .automatic)
                        .navigationBarItems(leading:         HStack{
                            ImportButton().padding(.trailing, 10)
                            
                            
                            NavigationLink(destination:AddHeaders().environmentObject(self.controlCenter).onAppear{
                            self.controlCenter.saveFileName = ""},isActive: self.$controlCenter.isActive)
                            {Image(systemName: "plus.square").font(.system(size: 20))}.isDetailLink(false)
                        }, trailing: Logo())
                }
            }
               //MARK: - IF NEWFILE IS ACTIVE
            else {
                NewFile().environmentObject(self.controlCenter).onAppear{
                    self.controlCenter.saveFileName = ""}
            }
        }
        .onAppear{print("MainNavigationView")
            initializeItems(control: self.controlCenter)
            emptyArrays(control: self.controlCenter)
            resetBools(control: self.controlCenter)
            getFiles(control: self.controlCenter,completion: {
                        print("Files Fetched")
               
                connectivityProvider.sendListNames()
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


