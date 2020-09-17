//
//  HeaderSelection.swift
//  quicklookCSV
//
//  Created by developer on 5/27/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//
//https://stackoverflow.com/questions/56790502/list-with-drag-and-drop-to-reorder-on-swiftui
import Foundation
import SwiftUI

//MARK: -HEADER SELECTION VIEW
struct HeaderSelection: View {

    @State private var isEditable = false
    @EnvironmentObject var controlCenter: ControlCenter
    @State var newHeader:String = ""
    @State var updateName:String = ""
    @State var currentHeader:String = ""
    @State var currentItemIndex:Int = 0
    @State private var toggle:Bool = false
    
    
    func printIndex(at offsets: IndexSet){
          let itemIndex:Int = offsets.first!
        print(itemIndex)
//          do { try FileManager.default.removeItem(at: controlCenter.recentFiles[itemIndex]) } catch { print("unable to delete file")}
//        controlCenter.recentFiles.remove(at: itemIndex)
//        controlCenter.urlFileNames.remove(at:itemIndex)
      }
    var body: some View {
        
        VStack{

            if self.controlCenter.showChangeHeaderName {
                UpdateHeaderName()
            }else{
            
                List{
                    //FOR EACH HEADER
                    ForEach(self.controlCenter.updatedHeaderNames.sorted(by: <), id: \.key) { key, value in
                        
                       
                        Button(action: {
                           
                            self.controlCenter.headerToChange = value
                        
                            
                            print("Header Section First Load Modified: \(self.controlCenter.showInitialList)")
                            
                            buildHeaderList(header: value, control: self.controlCenter, completion: { print(self.controlCenter.selectedHeaders)})
                            
                            //self.toggle.toggle()
                        })
                        {
                            //INDEX THROUGH UPDATED HEADER NAMES TO DISPLAY THE LIST
                            //updatedHeaderNames is set in CSVList.swift Line 111
                            //ALL HEADERS ARE SET TO THE KEY AND VALUE OF the updateHeaderNames Dictionary.
                            //originalHeaders is set in CSVaccessabiltiy when they are imported.
                            //updatedHeaders is being accessed by its keys which will never change...
                            HStack{
                                //BELOW WILL SHOW A FILL PENCIL CIRCLE IF A HEADER HAS BEEN MODIFIED
                                if value != key {
                                    Image(systemName: "pencil.circle.fill").font(.system(size: 20))
                                        .onTapGesture{
                                           // print(itemIndex)
                                            //THESE VARIABLES ARE USED TO CHANGE THE HEADER NAME
                                            //GET THE INDEX OF THE CURRENT HEADER
                                           // self.controlCenter.currentItemIndex = index
                                            //CHANGE HEADER NAME TO TRUE TO SHOW VIEW
                                            self.controlCenter.showChangeHeaderName = true
                                            //SET THE NEWHEADER NAME TO CURRENT HEADER : GOTO LINE 26
                                           // print(self.controlCenter.headers[index])
                                            self.controlCenter.headerToChange = value
                                            self.controlCenter.headerKey = key
                                    }
                                }else {
                                    Image(systemName: "pencil.circle").font(.system(size: 20))
                                        .onTapGesture{
                                           // print(id)
                                           // self.controlCenter.currentItemIndex = key
                                            self.controlCenter.showChangeHeaderName = true
                                            //print(self.controlCenter.headers[index])
                                            self.controlCenter.headerToChange = value
                                            self.controlCenter.headerKey = key
                                    }
                                }
                                //CURRENT HEADER NAME
                                Text(value)
                                    .font(.body).bold().padding(.all, 8)
                            }
                            //TOGGLE ROW BACKGROUND COLOR
                        }.listRowBackground(self.controlCenter.selectedHeaders.contains{ header in
                            
                            if case key = header {
                                print("si senior")
                               return true
                             }
                            if case value = header {
                                print("dose")
                                return true
                            }else {
                                print("el falso")
                             return false
                            }
                            } ? Color.blue : Color(UIColor.systemGroupedBackground))
                    }
                }.onAppear{
                  
                    self.controlCenter.arrayCount=self.controlCenter.initialList.count
                    self.controlCenter.itemDidView = false
                    self.controlCenter.headersViewAccessed = true
                    print(self.controlCenter.selectedHeaders)
                    print(self.controlCenter.modifiedList.count)
                }
            }

        }
                .navigationBarTitle("Headers")
    }
    
    func move(from source: IndexSet, to destination: Int) {
        self.controlCenter.headers.move(fromOffsets: source, toOffset: destination)
        withAnimation {
                   isEditable = false
               }
    }
}
