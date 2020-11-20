//
//  UnmodifiedList.swift
//  quicklookCSV
//
//  Created by developer on 5/28/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftUIRefresh


struct CSVList: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var controlCenter: ControlCenter
    @ObservedObject var recognizedText: RecognizedText = RecognizedText()
    @ObservedObject var connectivityProvider: ViewModel = ViewModel(connectivityProvider: ConnectivityProvider())
   // @ObservedObject var viewModel:ViewModel
    
    @State var array: [String] = []
    @State var text:String = ""
    @State var fontSize:CGFloat = 10
    @State private var selectedItem = 0
    @State private var isShowing = false
    @State var ShowStateArray = false
    @State private var isShowingScanner = false
    @State private var isShowingTextRecognition = false

    //@State var scannedItems:String = ""
    
    let pasteboard = UIPasteboard.general

    
    func removeItems(at offsets: IndexSet){
        
        let itemIndex:Int = offsets.first!
        var tupleToRemove:[(key: String, value: String)] = []
        
       var listItem:String = String()
        
        //MARK: -UPDATE LIST ITEMS
        if self.controlCenter.selectedHeaders.count == 0 && self.controlCenter.ShowStateArray == false{
            listItem = controlCenter.initialList[itemIndex]
            for indx in 0..<self.controlCenter.modifiedList.count {
                        if self.controlCenter.modifiedList[indx] == listItem {
                            self.controlCenter.modifiedList.remove(at: indx)
                            break
                        }
                    }
            self.controlCenter.initialList.remove(at: itemIndex)
            
        }
        else if self.controlCenter.selectedHeaders.count != 0 && self.controlCenter.ShowStateArray == false {
            
            listItem = controlCenter.modifiedList[itemIndex]
            for indx in 0..<self.controlCenter.initialList.count {
                          if self.controlCenter.initialList[indx] == listItem {
                              self.controlCenter.initialList.remove(at: indx)
                              break
                }}
            
            self.controlCenter.modifiedList.removeAll{$0 == controlCenter.initialList[itemIndex]}
        }
        else if self.controlCenter.ShowStateArray {
            listItem = self.array[itemIndex]
            for indx in 0..<self.controlCenter.initialList.count {
                if self.controlCenter.initialList[indx] == listItem {
                    self.controlCenter.initialList.remove(at: indx)
                    break
                }
            }
            for indx in 0..<self.controlCenter.modifiedList.count {
                if self.controlCenter.modifiedList[indx] == listItem {
                    self.controlCenter.modifiedList.remove(at: indx)
                    break
                }
            }
            
            
            self.array.remove(at: itemIndex)
            
            
        }

        var tmpHeaders:[String] = []
        var headerCount:Int = 0
        var itemArray:[String] = listItem.components(separatedBy: "\n")
        var key:String = String()
        var value:String = String()
        itemArray = itemArray.dropLast()
        print("Chickro")
        for item in 0..<itemArray.count {
            
               if self.controlCenter.selectedHeaders.count != 0 {
                 tmpHeaders = self.controlCenter.selectedHeaders.sorted {$0.localizedCompare($1) == .orderedAscending}
                 headerCount = tmpHeaders[item].count+1
               }else {
                 tmpHeaders = self.controlCenter.headers.sorted {$0.localizedCompare($1) == .orderedAscending}
                 headerCount = tmpHeaders[item].count+1
                }
           
            
              if itemArray[item].contains(":") {
                key = tmpHeaders[item]
                value = itemArray[item].dropFirst(headerCount).description
                print("nuts")
                print(itemArray[item].dropFirst(headerCount))
                tupleToRemove.append((key:key, value:value))
            }
              else {
                value = itemArray[item].dropFirst(headerCount).description
            }
        
        }
        
        for indx in 0..<self.controlCenter.initialTuple.count {
            var x = 0
            
            for (key, value) in self.controlCenter.initialTuple[indx]{
                
                for item in tupleToRemove {
                    if key == item.key {
                        if value.trimmingCharacters(in: .whitespacesAndNewlines) == item.value.trimmingCharacters(in: .whitespacesAndNewlines) {
                            x+=1
                        } else { break }
                    }
                }
            }
            if x == tmpHeaders.count {
                self.controlCenter.initialTuple.remove(at: indx)
                print("Fritog")
                break
            }
        }
              
        for indx in 0..<self.controlCenter.modifiedTuple.count {
            var x = 0
            
            for (key, value) in self.controlCenter.modifiedTuple[indx]{
                
                for item in tupleToRemove {
                    if key == item.key {
                        if value.trimmingCharacters(in: .whitespacesAndNewlines) == item.value.trimmingCharacters(in: .whitespacesAndNewlines) {
                            x+=1
                        } else { break }
                    }
                }
            }
            if x == tmpHeaders.count {
                self.controlCenter.modifiedTuple.remove(at: indx)
                print("Gritog")
                break
            }
        }
            
        print("Here is the item your removing.")
        print(tupleToRemove)
        print("Hawaii")
        self.controlCenter.arrayCount = self.controlCenter.arrayCount - 1
    }
    
    
    
    
    //MARK: - HANDLE BARCODE SCAN
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        switch result {
        case .success (let code):
            let details = code.components(separatedBy: "\n")
            print(details[0].description)
            self.text = details[0]
            self.controlCenter.isShowingScanner = false
            self.controlCenter.searchTerm = details[0]
            self.text = self.controlCenter.searchTerm
            pasteSearch(control: self.controlCenter, array: &self.array, searchText: details[0], completion: {
                self.controlCenter.ShowStateArray = true})
            
        case .failure(let error):
            print("scanning failed")
            print(error)

        }
    }
    
    var body: some View {
        
        LoadingView(isShowing: .constant(self.controlCenter.loading)) {
           // ScrollView{
            VStack {
                if self.controlCenter.showLists {
                    
                    //MARK: -SEARCHBAR
                    HStack{
                        //PASTE TO SEARCH
                        Button(action:{self.controlCenter.searchTerm = self.pasteboard.string ?? ""
                            self.text = self.controlCenter.searchTerm
                            pasteSearch(control: self.controlCenter, array: &self.array, searchText: self.controlCenter.searchTerm, completion: {
                                self.controlCenter.ShowStateArray = true
                                UIApplication.shared.endEditingFirstResponder()
                                
                                })
                        }){Image(systemName: "doc.on.clipboard.fill").padding(.init(top: 0, leading: 8, bottom: 0, trailing: 8))}
                        //MARK:- SEARCH BAR
                    
                        SearchBar(controlCenter: self._controlCenter, text: self.$text, array: self.$array)
                            .contextMenu {
                                //MARK: - BARCODE SCAN
                                   
                                Button(action:
                                    {
                                        self.controlCenter.isShowingScanner.toggle()
                                        self.isShowingTextRecognition = false
                                }){Text("Barcode Scanner")
                                    Image(systemName: "barcode")
                                }
                                
                                Button(action:
                                    {
                                        self.controlCenter.isShowingScanner.toggle()
                                        self.isShowingTextRecognition = true
                                }){Text("Text Scanner")
                                    Image(systemName: "doc.text.viewfinder")
                                }
                                
                        }
                        
                        
                    }
                    
                   // Button(action:{print(self.controlCenter.initialList)}){Text("Button")}
                    
                    //MARK: -INITIAL LIST
                    List{
                        if self.controlCenter.selectedHeaders.count == 0 && self.controlCenter.ShowStateArray == false{
                            //SHOW DATA UPON IMPORTING...
                            if self.controlCenter.showInitialList{
                               // InitialListView()
                                ForEach(0..<self.controlCenter.initialList.count, id:\.self) { item in
                                    NavigationLink(destination:ItemView(currentItem: self.controlCenter.initialList[item], headers: self.controlCenter.headers, selectedHeaders: self.controlCenter.selectedHeaders).onAppear{
                                        self.controlCenter.currentItem = self.controlCenter.initialList[item]
                                      //  currentArray = [self.controlCenter.initialList[item]]
                                        
                                        print("accessed from initialList")
                                        })
                                    {Text(self.controlCenter.initialList[item]).font(.system(size: self.controlCenter.fontSize))}
                                }
                                .onDelete(perform: self.removeItems)
                            }
                        }
                            
                        else if self.controlCenter.selectedHeaders.count != 0 && self.controlCenter.ShowStateArray == false {
                            //ModifiedListView()
                            ForEach(0..<self.controlCenter.modifiedList.count, id:\.self) { item in
                                NavigationLink(destination:ItemView(currentItem: self.controlCenter.initialList[item], headers: self.controlCenter.headers, selectedHeaders: self.controlCenter.selectedHeaders).onAppear{
                                           self.controlCenter.currentItem = self.controlCenter.modifiedList[item]
                                            print("accessed from modifiedList")
                                          
                                           })
                                       {Text(self.controlCenter.modifiedList[item]).font(.system(size: self.controlCenter.fontSize))}
                                       }.onDelete(perform: self.removeItems)
                        }
                            
                           //MARK: - SHOW SORTED ARRAY
                        else if self.controlCenter.ShowStateArray {
//                            StateArrayView(array: self.array, text: self.text)
                            ForEach(0..<self.array.count, id:\.self) { item in
                                    NavigationLink(destination:ItemView(currentItem: self.array[item], headers: self.controlCenter.headers, selectedHeaders: self.controlCenter.selectedHeaders).onAppear{
                                        self.controlCenter.currentItem = self.array[item]
                                          print("accessed from initial list selectedHeaders Show State Array == [] array != []")
                                        })
                                    {Text(self.array[item]).font(.system(size: self.controlCenter.fontSize))}
                                    }
                            .onDelete(perform: self.removeItems)
                            

                        }
                    }
                   
                        .padding(.init(top: 0, leading: 8, bottom: 0, trailing: 8))
                        .id(UUID())
                        .pullToRefresh(isShowing: self.$isShowing) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                print("Refresh")
                                pullReset(text: &self.text, array: &self.array, control: self.controlCenter)
                                self.isShowing = false
                            }
                    }
                    //MARK: -FOOTER NAVIGATION BAR
                    FootNavBar().environmentObject(self.controlCenter)
                }
            }
           
                
            .resignKeyboardOnDragGesture()
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(Text(self.controlCenter.fileName), displayMode:  .inline)
            .navigationBarItems(leading: HStack{
                
                Button(action:{
                    //MARK: - Re-initialize and go to ContentView
                    initializeItems(control: self.controlCenter)
                    emptyArrays(control: self.controlCenter)
                    resetBools(control: self.controlCenter)
                    self.controlCenter.newFileIsActive = false
                    self.controlCenter.isActive = false
                    getFiles(control: self.controlCenter,completion: {print("Files Fetched")})
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "chevron.left")
                    Text("Back")}.padding(.trailing, 10)
                
                Button(action: {
                    connectivityProvider.sendList()
                    
                }){Image(systemName:"applewatch").font(.system(size: 20))}.environmentObject(controlCenter)
                
            } , trailing: TopNavbarButtons().environmentObject(self.controlCenter))
                
                .onAppear{
                   
                    print(self.controlCenter.initialList)
                    print("returnFromItemSelection \(self.controlCenter.returnFromItemSelection)")
                    print("headersViewAccessed \(self.controlCenter.headersViewAccessed)")
                    print("returnFromSave \(self.controlCenter.returnFromSave)")
                    print(self.controlCenter.searchTerm)
                    self.controlCenter.itemViewIsShowing = false
                    self.controlCenter.listIsLoaded = true
                    if self.controlCenter.firstTimeEditingHeaders == false && self.controlCenter.itemDidView == false {
                        changeHeaderNamesSortedItems(control: self.controlCenter,completion: {
                            self.controlCenter.loading = false})
                        
                        self.text = self.controlCenter.searchTerm
                        print("self.controlCenter.firstTimeEditingHeaders == false && self.controlCenter.itemDidView == false")
                    }
                    
                    if self.controlCenter.selectedHeaders == [] && self.controlCenter.returnFromSave == false && self.controlCenter.itemDidView == false{
                        self.controlCenter.showInitialList = true
                        self.text = self.controlCenter.searchTerm
                        //  self.array.removeAll()
                        
                        print("self.controlCenter.selectedHeaders == [] && self.controlCenter.returnFromSave == false && self.controlCenter.itemDidView == false")
                    }
                    
                    //MARK: - FIRST LOAD
                    if self.controlCenter.itemDidView == false && self.controlCenter.headersViewAccessed == false && self.controlCenter.cloudFile == false && self.controlCenter.returnFromSave == false && self.controlCenter.AddItemDidView == false {
                        self.controlCenter.loading = true
                        self.text = self.controlCenter.searchTerm
                        print(self.controlCenter.returnFromSave)
                        print(self.controlCenter.initialList.count)
                        print("First Load")
                        csvToList(control: self.controlCenter, completion: {
                            self.controlCenter.headersViewAccessed = false
                            self.controlCenter.loading = false
                            // self.$controlCenter.searchTerm.wrappedValue = ""
                            self.controlCenter.arrayCount=self.controlCenter.initialList.count
                            // print(self.controlCenter.arrayCount)
                            connectivityProvider.sendList()
                           // connectivityProvider.sendMessage()
                            print("First Load")
                        })
                        
                   
                }
                
                //UPDATE SELECTED HEADERS IN MAIN LIST / IF NO HEADERS HAVE BEEN MODIFIED YET
                if self.controlCenter.headersViewAccessed == true && self.controlCenter.selectedHeaders != [] && self.controlCenter.returnFromSave == false && self.controlCenter.itemDidView == false && self.controlCenter.returnFromSave == false {
     
                            sortedSelectedModifiedHeaders(control: self.controlCenter, completion: {
                               // self.controlCenter.ShowStateArray = false
                                self.array.removeAll()
                                print("Modified Items")
                              //  self.controlCenter.ShowStateArray = false
                                if self.controlCenter.searchTerm.count != 0 {
                                    pasteSearch(control: self.controlCenter, array: &self.array, searchText: self.controlCenter.searchTerm, completion: {self.controlCenter.ShowStateArray = true})
                                }
                                self.controlCenter.loading = false
                            })
                    print("UPDATE SELECTED HEADERS IN MAIN LIST / IF NO HEADERS HAVE BEEN MODIFIED YET")
                }
                
                
                //CLEAR ARRAY AFTER RETURNING FROM HEADER SELECTION
                if self.controlCenter.returnFromSave == false && self.controlCenter.headersViewAccessed && self.controlCenter.itemDidView == false{
                  self.array.removeAll()
                  //  if self.controlCenter.selectedHeaders != [] { self.controlCenter.ShowStateArray = false}
                   self.controlCenter.ShowStateArray = false
                    print("CLEAR ARRAY AFTER RETURNING FROM HEADER SELECTION")
                    print(self.controlCenter.searchTerm)
                }
                
                //USE FOR ADDING ITEMS
                if self.controlCenter.AddItemDidView == true {
                     pullReset(text: &self.text, array: &self.array, control: self.controlCenter)
                }
             
            }
            //MARK: - BARCODE SCANNER
                .sheet(isPresented: self.$controlCenter.isShowingScanner) {
                    if self.isShowingTextRecognition {
                        ScanningView(recognizedText: self.$text).environmentObject(self.controlCenter)                    }
                    else{
                        CodeScannerView(codeTypes: [.ean8, .ean13, .pdf417, .upce, .code39], simulatedData: "Test",completion: self.handleScan)}
            }
        }
    }
}
    



