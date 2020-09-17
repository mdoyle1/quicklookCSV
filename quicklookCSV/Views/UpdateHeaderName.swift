//
//  UpdateHeaderName.swift
//  quicklookCSV
//
//  Created by developer on 6/10/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI

struct UpdateHeaderName: View {
    @EnvironmentObject var controlCenter:ControlCenter
    @State var updateName:String = String()
    @State var newHeader:String = String()
    var body: some View {
        VStack{
            Text("Change Name").font(.headline).bold().padding(.all, 10)
            
            HStack{
                //TEXT FIELD HAS HEADER NAME AS A PLACEHOLDER
                TextField(self.controlCenter.headerKey,text:$updateName)
                    .padding(.all, 10)
                    .background(Color(.gray).opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(.primary)
                
                
                //CHANGE HEADER NAME ACTIONS
                Button(action:{
                    
                    self.controlCenter.firstTimeEditingHeaders = false
                    
                    //REMOVE ANY TRACE OF THE ORIGINAL HEADERS...
                    self.controlCenter.selectedHeaders.removeAll{ $0 == self.controlCenter.headerToChange }
                    //                    self.controlCenter.selectedHeaders.removeAll{ $0 == self.controlCenter.headerKey }
                    buildHeaderList(header: self.updateName, control: self.controlCenter, completion: { print(self.controlCenter.selectedHeaders)})
                    
                    //ITTERATE THOUGH EACH DICTIONARY IN updatedHeaderNames
                    //headerToChange is the selected header from HeaderSelection.swift Line 59
                    for item in self.controlCenter.updatedHeaderNames {
                        print("if \(item.value) is == to \(self.controlCenter.headerToChange)")
                        if item.value == self.controlCenter.headerToChange {
                            self.controlCenter.updatedHeaderNames[item.key] = self.updateName
                        }
                        
                    }
                    
                    print("THE UPDATEDHEADERNAMES ARRAY")
                    print(self.controlCenter.updatedHeaderNames)
                    
                    print(self.controlCenter.headers[self.controlCenter.currentItemIndex])
                    print("THIS IS THE NEW HEADER NAME")
                    print(self.updateName)
                    self.controlCenter.showChangeHeaderName = false
                    
                    //MAKE SURE HEADER IS NOT BLANK!
                    //                    if self.updateName == "" {
                    //                        self.updateName = self.controlCenter.headerToChange
                    //                        self.controlCenter.selectedHeaders.removeAll { $0 == self.controlCenter.updatedHeaderNames[self.controlCenter.headerToChange]}
                    //                    }
                    
                    
                }){Image(systemName:"return").font(.system(size: 25))}
            }.padding(.all, 10)
            Button(action: {
                print("Dismiss")
                self.controlCenter.showChangeHeaderName = false
            }){Text("Dismiss").modifier(ButtonFormat())}
            Spacer()
        }.padding(.all, 10)
            .background(Color(.blue).opacity(0.2))
            .cornerRadius(10)
            .padding(.all, 10)
    }
}


