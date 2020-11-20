//
//  ExportItems.swift
//  quicklookCSV
//
//  Created by developer on 6/8/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI

struct PinNewList: View {
    @EnvironmentObject var controlCenter:ControlCenter
    @Environment(\.presentationMode) var presentationMode
    @State var fileName: String = ""
    let pasteboard = UIPasteboard.general
    
    var body: some View {
        LoadingView(isShowing: .constant(self.controlCenter.loading)) {
            VStack{
                VStack{
                    
                    Text("Pin Current List").bold().underline()
                        .font(.headline)
                        .padding(.all, 8)
                    HStack{
                        Button(action:{
                            
                            self.controlCenter.fileName = self.pasteboard.string ?? ""
                        }){Image(systemName: "doc.on.clipboard.fill").padding(.init(top: 0, leading: 8, bottom: 0, trailing: 8))}
                        
                        TextField("Enter new file name..", text: self.$controlCenter.fileName)
                            .padding(.all, 8)
                            .background(Color(.gray).opacity(0.5)).cornerRadius(10)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            
                    }
                    Button(action:{
                        self.controlCenter.returnFromSave = true
                        self.controlCenter.loading = true
                        self.presentationMode.wrappedValue.dismiss()
                        exportOrCompressCSV(control: self.controlCenter, exportFile: true, filterString: self.controlCenter.searchTerm, fileName: self.controlCenter.fileName+".csv", completion: {
                            
                            print("Exported \(self.fileName).csv")
                            self.controlCenter.loading = false
                        })
                    }){Text("Save")}
                        .modifier(ButtonFormat())
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                    
                }.padding(.all, 10)
                    .background(Color(.gray).opacity(0.2))
                    .cornerRadius(10)
                    .padding(.all, 10)
                    .onAppear{
                        print("Save Filter \(self.controlCenter.searchTerm)")
                        
                        self.controlCenter.fileName = self.controlCenter.fileName.replacingOccurrences(of: ".csv", with: "")
                        
                }
                Spacer()
            }
        }
    }
    
}


