//
//  ColumnButton.swift
//  quicklookCSV
//
//  Created by developer on 5/29/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import Foundation
import SwiftUI


struct ColumnButton: View {
@EnvironmentObject var controlCenter: ControlCenter
@State private var isPresented = false
var body: some View {
Button(action: {
               self.controlCenter.showHeaders.toggle()
               self.controlCenter.showLists.toggle()
               self.controlCenter.showInitialList = true
               //SET SELECTED ITEMS TO SORTED ITEMS... MOVES ALL DATA TO ANOTHER BUCKET FOR SORTING...
               self.controlCenter.modifiedTuple = self.controlCenter.initialTuple
               sortedSelectedItems(control: self.controlCenter, completion: {print(self.controlCenter.modifiedList)})
              
               if self.controlCenter.selectedHeaders == [] {
               self.controlCenter.listIsModified = false
                 
               } else {
                   self.controlCenter.listIsModified = true
                   
               }
           })
           {if self.controlCenter.showHeaders{Text("headers").opacity(0.5)}
               if self.controlCenter.showHeaders == false {
                   Text("headers")
               }
           }
}
}
