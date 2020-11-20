//
//  WatchButtons.swift
//  quicklookCSV
//
//  Created by Mark Doyle on 11/7/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import Foundation
import SwiftUI

struct WatchButtons:View {
    @Binding var listView:Bool
    var savedItem:String
    var listName:String
    
    
    var body: some View {

Button(action:{
    listView.toggle()
    if sharedUserDefaults?.stringArray(forKey:savedItem) == [] {
        sharedUserDefaults?.setValue(arrayAny, forKey: savedItem)
    } else {
    arrayAny = sharedUserDefaults?.stringArray(forKey:savedItem) ?? []
    }
}){Text(listName)}
        
    }
    
}
