//
//  NewFile.swift
//  quicklookCSV
//
//  Created by developer on 8/2/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI

struct NewFile: View {
    @EnvironmentObject var controlCenter:ControlCenter
    @State var newFileName:String = String()
    
  
    var body: some View {
        VStack(alignment: .center){
            
            TextField("Enter New File Name", text: self.$controlCenter.fileName)
                .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                .background(Color(.gray).opacity(0.5)).cornerRadius(10)
            
            NavigationLink(destination:AddHeaders().onAppear{
                self.controlCenter.fileName = self.$controlCenter.fileName.wrappedValue
            }.environmentObject(self.controlCenter),isActive: self.$controlCenter.isActive){Text("Save")
                
                .modifier(ButtonFormat())} .isDetailLink(false)
            Spacer()
        }.padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
            .navigationBarTitle("New File")
      
    }
    
}

struct AddHeaders: View {
    @EnvironmentObject var controlCenter:ControlCenter
    @State var newHeader:String = String()
    @State var headers:[String] = []
    
    func removeItems(at offsets: IndexSet){
        let itemIndex:Int = offsets.first!
        self.headers.remove(at: itemIndex)
    }
    var body: some View {
        VStack(alignment: .center){
            
            TextField("Enter Header Name", text: $newHeader)
                .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                .background(Color(.gray).opacity(0.5)).cornerRadius(10)
            HStack{
                Button(action: {
                    print(self.newHeader)
                    self.headers.append(self.newHeader)
                    print(self.headers)
                    self.newHeader = ""
                }){Text("Add")}
                    .modifier(ButtonFormat())
                
                NavigationLink(destination:CSVList()
                    
                    .environmentObject(self.controlCenter).onAppear{
                        
                        print(self.newHeader)
                        self.controlCenter.headers = self.headers
                        //CREATE UPDATEDHEADERNAMES DICTIONARY FOR STORING ORIGINAL HEADER NAMES AND MODIFYING
                        for header in self.headers {
                            self.controlCenter.updatedHeaderNames[header]=header
                            self.controlCenter.AddItem[header]=""
                            //                control.Items.append(CSVItems(key: header, value: ""))
                        }
                        //ORIGINAL HEADERS IS USED TO RESET HEADER LIST IF MODIFIED
                        self.controlCenter.originalHeaders = self.headers
                        
                    })
                {Text("Done")}.isDetailLink(false)
                    .modifier(ButtonFormat())}
            
            
            List{
                ForEach(self.headers, id: \.self){ header in
                    Text(header)
                }.onDelete(perform: removeItems)
            }
            
            Spacer()
        }.padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
            .navigationBarTitle("Add Headers")
        
    }
    
}

