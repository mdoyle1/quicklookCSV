//
//  AddItem.swift
//  quicklookCSV
//
//  Created by developer on 7/9/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//
//https://github.com/twostraws/CodeScanner

import SwiftUI
//import CodeScanner


struct AddItem: View {
    @EnvironmentObject var controlCenter: ControlCenter
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var recognizedText: RecognizedText = RecognizedText()
    
    @State var itemArray:[String] = []
    @State var itemsBrokenDown: [[String]] = []
    @State var text:String = ""
    @State var showAll:Bool = true
    @State var currentKey = ""
    @State var currentValue = ""
    @State private var isShowingScanner = false
    @State private var isShowingTextRecognition = false
    @State var scannedCode: String?
    @State var scannedItems:String = ""
    @State var didScan:Bool = false
    
    
//MARK: - HANDLE BARCODE SCAN
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        switch result {
        case .success (let code):
            let details = code.components(separatedBy: "\n")
            
            print(self.currentKey)
            self.controlCenter.AddItem[self.currentKey] = details[0].description
            print(details[0].description)
            self.scannedItems = details[0]
            self.controlCenter.isShowingScanner = false
        case .failure(let error):
            print("scanning failed")
            print(error)
            
        }
    }
    
    
    
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    
                    VStack(alignment: .leading){
                        
                        ForEach(self.controlCenter.AddItem.sorted(by: <), id: \.key) { key, value in
                            VStack{
                                HStack{
                                    
                                    Text("\(key): ")
                                    TextField("New Value...", text:Binding<String>(
                                        get: {self.controlCenter.AddItem[key] ?? "<none>"}, set: {
                                            self.controlCenter.AddItem[key] = $0}))}
                                    .contextMenu {
                                        //MARK: - BARCODE SCAN
                                        Button(action:
                                            {self.controlCenter.isShowingScanner.toggle()
                                                self.isShowingTextRecognition = false
                                                self.currentKey = key
                                                self.didScan.toggle()
                                        }){Text("Barcode Scanner")
                                            Image(systemName: "barcode")
                                        }
                                        
                                        Button(action:
                                            {
                                                self.controlCenter.addItemTextScan = true
                                                self.controlCenter.isShowingScanner.toggle()
                                                self.controlCenter.addItemTextScan = true
                                                self.isShowingTextRecognition = true
                                                self.currentKey = key
                                                self.controlCenter.currentKey = key
                                        }){Text("Text Scanner")
                                            Image(systemName: "doc.text.viewfinder")
                                        }
                                        
                                }
                                
                                
                            }
                        }
                    }
                    .padding(.all, 15)
                    .background(Color(.darkGray).opacity(0.3)) .cornerRadius(10)
                    .onAppear{
                        self.controlCenter.AddItemViewIsShowing = true
                        self.controlCenter.AddItemDidView = true
                    }
                    
                }.padding(.trailing, 10)
                
                //BLANK IS NEEDED TO KEEP SCROLL VIEW WORKING W/O BLANK, THE VIEW IS SQUISHED
                VStack{
                    Blank()
                }
                
                
                Spacer()
                VStack{
                    HStack{
                        ZoomOUT()
                        Spacer()
                        Button(action: {
                            print(self.controlCenter.AddItem)
                            self.controlCenter.itemToAdd.removeAll()
                            for (key,value) in self.controlCenter.AddItem {
                                self.controlCenter.itemToAdd.append((key: key, value: value))
                            }
                            print(self.controlCenter.itemToAdd)
                            self.controlCenter.initialTuple.append(self.controlCenter.itemToAdd.sorted(by: {$0.key < $1.key }))
                            sortedItems(control: self.controlCenter)
                            self.presentationMode.wrappedValue.dismiss()
                        }){Text("Submit")}
                        Spacer()
                        ZoomIN()
                    }
                }.padding(.all, 10)
            }
            .padding(.all, 8)
            .navigationBarTitle(self.controlCenter.fileName)
                
                //MARK: - BARCODE SCANNER 
                .sheet(isPresented: self.$controlCenter.isShowingScanner) {
                    if self.isShowingTextRecognition {
                        ScanningView(recognizedText: self.$recognizedText.value).environmentObject(self.controlCenter)
                    }
                    else{
                        CodeScannerView(codeTypes: [.ean8, .ean13, .pdf417, .upce, .code39], simulatedData: "Test",completion: self.handleScan)}
            }
            
        }.onAppear{
            for (key,_) in self.controlCenter.AddItem {
                self.controlCenter.AddItem[key] = ""
            }
        }
    }
}
