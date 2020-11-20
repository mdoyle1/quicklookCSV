//
//  CSVListView.swift
//  watchCSV Extension
//
//  Created by Mark Doyle on 11/11/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI

struct CSVListView: View {
    @State var searchText:String = ""
    @Binding var watchListCount:Int
    @Binding var watchList:[String]
    @Binding var showSettingsView:Bool
    @Binding var showListView:Bool
    
    @Binding var a:Bool
    @Binding var b:Bool
    @Binding var c:Bool
    @Binding var d:Bool
    
    @State var newSearchList:[String] = []
    
    func removeItems(at offsets: IndexSet){
        let itemIndex:Int = offsets.first!
        print("Delete")
        
        self.watchList.remove(at: itemIndex)
        if a {
            sharedUserDefaults?.setValue(watchList, forKey:SharedUserDefaults.Keys.firstList)
        }
    }
    var body: some View {
        
        List{
            Section(header: VStack{
                TextField("Search List", text: $searchText, onCommit: {
                    if searchText == "" {
                        watchListCount = watchList.count
                    }else {
                        watchListCount = 0
                for item in watchList {
                    if item.lowercased().contains(searchText.lowercased()){
                        watchListCount+=1
                    }
                }
                }})
                HStack{
                Text("Total: ").font(.footnote)
                    Text(String(watchListCount))
                }
            }
                )
            {
                ForEach(watchList, id:\.self) { item in
                    if searchText == ""  || item.lowercased().contains(searchText.lowercased()){
                        Text(item).font(.footnote).padding()
                    }
                }.onDelete(perform: self.removeItems)
            }
        }
        .navigationTitle(fileName ?? "")
    }
    
    
}

