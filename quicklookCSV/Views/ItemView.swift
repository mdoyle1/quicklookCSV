//
//  ItemView.swift
//  quicklookCSV
//
//  Created by developer on 6/24/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI

//MARK: -ITEM VIEW
struct ItemView: View {
    @EnvironmentObject var controlCenter: ControlCenter
    @State var itemArray:[String] = []
    @State var itemsBrokenDown: [[String]] = []
  
    let pasteboard = UIPasteboard.general
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    VStack(alignment: .leading){
                        ForEach(0..<itemArray.count, id: \.self){ item in
                            Button(action:{
                                
                                //METHOD TO EXTRACT VALUES FROM KEY IN LIST
                                var tmpHeaders:[String] = []
                                var headerCount:Int = 0
                                if self.controlCenter.selectedHeaders.count == 0 {
                                tmpHeaders = self.controlCenter.headers.sorted {$0.localizedCompare($1) == .orderedAscending}
                                headerCount = tmpHeaders[item].count+1
                                }else {
                                    tmpHeaders = self.controlCenter.selectedHeaders.sorted {$0.localizedCompare($1) == .orderedAscending}
                                    headerCount = tmpHeaders[item].count+1
                                }
                                //COPY ITEM VALUE ONLY
                                if self.itemArray[item].contains(":") {
                                    print(tmpHeaders[item].count+1)
                                    print("Here is your header " + "\(tmpHeaders[item])")
                                    print("Here is the original header " + "\(tmpHeaders)")
                                    
                                    //MARK: - EDIT THE STRING TO COPY
                                    let clipBoard = String(self.itemArray[item].dropFirst(headerCount).trimmingCharacters(in: .whitespacesAndNewlines))
                                    
                                    self.pasteboard.string = clipBoard
                                    
                                    self.controlCenter.searchTerm = clipBoard
                                    print(tmpHeaders)
                                    print(clipBoard)
                                    
                                }else{
                                    //COPY KEY AND VALUE
                                    self.pasteboard.string = self.itemArray[item].trimmingCharacters(in: .whitespacesAndNewlines)
                                    self.controlCenter.searchTerm = self.itemArray[item].trimmingCharacters(in: .whitespacesAndNewlines)
                                    print( self.itemArray[item])
                                }
                            }){
                                Text(self.itemArray[item])
                                    .foregroundColor(.primary)
                                    .font(.system(size: self.controlCenter.itemFontSize))
                                    .padding(.all, 8)
                                    .background(Color(.gray)).cornerRadius(10)
                            }.padding(.all, 8)
                            
                           .contextMenu {
                            Button(action: {
                                let formattedString = self.itemArray[item].components(separatedBy: "\(self.controlCenter.headers[item].trimmingCharacters(in: .whitespacesAndNewlines))"+":")[1]
                                print("This is your formatted String")
                            print(formattedString)
                             guard let url = URL(string: formattedString) else { return }
                      //       UIApplication.shared.open(url)
                                 UIApplication.shared.open(URL(string: formattedString)!)
                             }) {
                             Text("Open Link")
                                Image(systemName: "link")
                                    }
                            Button(action: {
                            let tel = "tel://"
                            let formattedString = tel +  self.itemArray[item].components(separatedBy: ":")[1].trimmingCharacters(in: .whitespacesAndNewlines)
                           print(formattedString)
                            guard let url = URL(string: formattedString) else { return }
                            UIApplication.shared.open(url)
                            }) {
                            Text("Call")
                            Image(systemName: "phone.fill.arrow.up.right")
                                   }
                                }
                        }
                    }
                    .padding(.all, 15)
                        
                    .background(Color(.darkGray).opacity(0.3)) .cornerRadius(10)
                        
                        
                    .onAppear{
                        //itemView IS USED FOR THE EXPORT OF DATA.
                        self.controlCenter.itemViewIsShowing = true
                        //itemDidView IS USED TO KEEP THE CSVList FROM RESORTING EVERY TIME A ITEM IS VIEWED
                        self.controlCenter.itemDidView = true
                       // print(self.controlCenter.currentItem)
                       // self.controlCenter.returnFromItemSelection = true
                        //CONVERT ITEM INTO AN ARRAY
                        let string = self.controlCenter.currentItem
                        let keyValue = self.controlCenter.currentItem
                        
             
                      //  let key = keyValue.components(separatedBy: ":")[0]
                        let value = keyValue.components(separatedBy: ":")[1]
                        print("Here is your value \(value)")

                        self.itemArray = string.components(separatedBy: "\n")
                        self.itemArray = self.itemArray.dropLast()

                    }
                    
                }.padding(.trailing, 10)
                
                //BLANK IS NEEDED TO KEEP SCROLL VIEW WORKING W/O BLANK, THE VIEW IS SQUISHED
                VStack{
                    Blank()
                }
            }
            HStack{
                ZoomOUT()
                Spacer()
                ZoomIN()
            }.padding(.all, 10)
        }
        .padding(.all, 8)
        .navigationBarTitle(self.controlCenter.fileName)
    
        .navigationBarItems(trailing: TopNavbarButtons())
        
    }
    
}
