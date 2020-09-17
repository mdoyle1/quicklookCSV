//
//  FootNavBar.swift
//  quicklookCSV
//
//  Created by developer on 6/11/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI

struct FootNavBar: View {
    @EnvironmentObject var controlCenter:ControlCenter
   
    var body: some View {
        HStack{
            ZoomOUT()
            
            HStack{
                Spacer()
                //HEADER SELECTION
                NavigationLink(destination: HeaderSelection().environmentObject(controlCenter)
                    .onAppear{
                        self.controlCenter.returnFromSave = false
                        self.controlCenter.showInitialList.toggle()
                        self.controlCenter.modifiedTuple = self.controlCenter.initialTuple
                    })
                {Image(systemName: "rectangle.split.3x1").modifier(ButtonFormat())}.padding(.trailing, 8)
                
                //PIN TO NEW LIST
                NavigationLink(destination: PinNewList().environmentObject(self.controlCenter)
                    .onAppear{
                        
                        self.controlCenter.returnFromSave = true})
                {Image(systemName: "pin").modifier(ButtonFormat())}.padding(.trailing, 8)
                
                //ADD ITEM
                NavigationLink(destination: AddItem().environmentObject(controlCenter)
                    .onAppear{
                        self.controlCenter.returnFromSave = true})
                {Image(systemName: "plus").modifier(ButtonFormat())}.padding(.trailing, 8)
                
                Total()
                Spacer()
                ZoomIN()
            }
        }.padding(.init(top: 0, leading: 8, bottom: 0, trailing: 8))
        
                   
    }
}

