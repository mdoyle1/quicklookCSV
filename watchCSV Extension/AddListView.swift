//
//  AddListView.swift
//  watchCSV Extension
//
//  Created by Mark Doyle on 11/7/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI

struct AddListView: View {
    @State var ListName:String = ""
    @State var showList:Bool = false
    
    var body: some View {
        if showList == false {
            VStack{
                TextField("Please name your list.", text: $ListName)
                Button(action:{
                    showList.toggle()
                }){Text("Submit")}
            }
        }
        
    }
    
}

