//
//  ContentView.swift
//  watchCSV Extension
//
//  Created by Mark Doyle on 11/5/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI

//CREATE A TEMPLATE TO ALLOW ADDING LISTS.
//CREATE A BUTTON TO ADD LIST.
//


struct ContentView: View {
    @State var listView:Bool = false
    @State var searchText:String = ""
    @State var showSettingsView:Bool = false
    @State var currentSelection:String = ""
    @State var currentFile:String = ""
    @State var showListView:Bool = false
    @State var showDelete:Bool = false
    
    @State var activateList:Color = Color(.green)
    @State var inactiveList:Color = Color(.gray)
    
    @State var a:Bool = false
    @State var b:Bool = false
    @State var c:Bool = false
    @State var d:Bool = false
    
    @State var firstListName = sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.firstListName)
    @State var secondListName = sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.secondListName)
    @State var thirdListName = sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.thirdListName)
    @State var fourthListName = sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.fourthListName)
    
    @State var arrayOfListNames = [sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.firstListName), sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.secondListName), sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.thirdListName), sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.fourthListName)]
    
    @State var arrayOfDefaults = [sharedUserDefaults?.stringArray(forKey:SharedUserDefaults.Keys.firstList), sharedUserDefaults?.stringArray(forKey:SharedUserDefaults.Keys.secondList), sharedUserDefaults?.stringArray(forKey:SharedUserDefaults.Keys.thirdList), sharedUserDefaults?.stringArray(forKey:SharedUserDefaults.Keys.fourthList)]
    
    
    @State var arrayOfKeys = [SharedUserDefaults.Keys.firstList, SharedUserDefaults.Keys.secondList, SharedUserDefaults.Keys.thirdList, SharedUserDefaults.Keys.fourthList]
@State var arrayOfNames = [SharedUserDefaults.Keys.firstListName, SharedUserDefaults.Keys.secondListName, SharedUserDefaults.Keys.thirdListName, SharedUserDefaults.Keys.fourthListName]
    
    @Binding var watchList:[String]
    @Binding var watchListCount:Int
    @Binding var csvFileNames:[String]
    
    
    var connectivityProvider: ConnectivityProvider
    
    @EnvironmentObject var controlCenter:ControlCenter
    init(connectivityProvider: ConnectivityProvider, watchList: Binding<[String]>, watchListCount: Binding<Int>, csvFileNames: Binding<[String]>) {
        self.connectivityProvider = connectivityProvider
        _watchList = watchList
        _watchListCount = watchListCount
        _csvFileNames = csvFileNames
    }
    
    func removeItems(at offsets: IndexSet){
        let itemIndex:Int = offsets.first!
        print("Delete")
        print(arrayOfListNames[itemIndex])
        sharedUserDefaults?.setValue(nil, forKey: arrayOfKeys[itemIndex])
        sharedUserDefaults?.setValue("Empty", forKey: arrayOfNames[itemIndex])
        arrayOfListNames.remove(at: itemIndex)
    }
   
    var body: some View {
        
      
        VStack{
        
            if sharedUserDefaults?.stringArray(forKey:SharedUserDefaults.Keys.savedLists)?.count == 0 {
               
                Text("Open a list in quicklookCSV on your iPhone, the Sync button will appear. If not, make sure your watch is paired with your iOS device.")
                    
                
            } else {

                //MARK:- CHOOSE WHICH SHARED DEFAULT TO SAVE TO.
                if showSettingsView {
                    ScrollView{
                    HStack{
                        if a {
                            CustomButton(currentSelection: $currentSelection, currentFile: $currentFile, buttonActivity: activateList, listNumber: "1", a:$a, b:$b, c:$c, d:$d, watchList:$watchList, showSettingsView:$showSettingsView)} else {
                                CustomButton(currentSelection: $currentSelection, currentFile: $currentFile, buttonActivity: inactiveList, listNumber: "1",a:$a, b:$b, c:$c, d:$d, watchList:$watchList, showSettingsView:$showSettingsView)
                            }
                        
                        if b {
                            CustomButton(currentSelection: $currentSelection, currentFile: $currentFile, buttonActivity: activateList, listNumber: "2", a:$a, b:$b, c:$c, d:$d, watchList:$watchList, showSettingsView:$showSettingsView)} else {
                                CustomButton(currentSelection: $currentSelection, currentFile: $currentFile, buttonActivity: inactiveList, listNumber: "2", a:$a, b:$b, c:$c, d:$d, watchList:$watchList, showSettingsView:$showSettingsView)
                            }
                    }
                    HStack{
                        if c {
                            CustomButton(currentSelection: $currentSelection, currentFile: $currentFile, buttonActivity: activateList, listNumber: "3", a:$a, b:$b, c:$c, d:$d, watchList:$watchList, showSettingsView:$showSettingsView)} else {
                                CustomButton(currentSelection: $currentSelection, currentFile: $currentFile, buttonActivity: inactiveList, listNumber: "3", a:$a, b:$b, c:$c, d:$d, watchList:$watchList, showSettingsView:$showSettingsView)
                            }
                        if d {
                            CustomButton(currentSelection: $currentSelection, currentFile: $currentFile, buttonActivity: activateList, listNumber: "4", a:$a, b:$b, c:$c, d:$d, watchList:$watchList, showSettingsView:$showSettingsView)} else {
                                CustomButton(currentSelection: $currentSelection, currentFile: $currentFile, buttonActivity: inactiveList, listNumber: "4", a:$a, b:$b, c:$c, d:$d, watchList:$watchList, showSettingsView:$showSettingsView)
                            }
                    }

                        Text("Open file on iOS quicklookCSV. Choose 1-4 to import your list.").font(.footnote).padding(.all, 10).background(Color(.gray).opacity(0.5)).cornerRadius(10)
                        Button(action:{showSettingsView.toggle()}){Text("Back")}

                    } } else {
                        AllListView(watchList: $watchList, watchListCount: $watchListCount, showSettingsView: $showSettingsView, showListView: $showListView, a:$a, b:$b, c:$c, d:$d)
                }

            }
            }
        
    }
}

