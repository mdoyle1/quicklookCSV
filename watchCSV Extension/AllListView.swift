//
//  AllListView.swift
//  watchCSV Extension
//
//  Created by Mark Doyle on 11/15/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI

struct AllListView: View {
    @Binding var watchList:[String]
    @Binding var watchListCount:Int
    @Binding var showSettingsView:Bool
    @Binding var showListView:Bool
    @Binding var a:Bool
    @Binding var b:Bool
    @Binding var c:Bool
    @Binding var d:Bool
    @EnvironmentObject var controlCenter:ControlCenter
    var body: some View {
        List{
            Section(header:
            Button(action: {
                showSettingsView.toggle()
                showListView.toggle()
            }){Text("Sync List").font(.headline)}
             
            ){
                NavigationLink("1. \(sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.firstListName) ?? "Empty List")" , destination: CSVListView(watchListCount: $watchListCount, watchList: $watchList, showSettingsView: $showSettingsView, showListView: $showListView, a:$a, b:$b, c:$c, d:$d).environmentObject(controlCenter).onAppear{
                fileName = sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.firstListName) ?? "Empty List"
                watchList = (sharedUserDefaults?.stringArray(forKey:SharedUserDefaults.Keys.firstList) ?? ["Empty"])
                watchListCount = sharedUserDefaults?.stringArray(forKey:SharedUserDefaults.Keys.firstList)?.count ?? 0                }).font(.footnote)
                
            
  
                NavigationLink("2. \(sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.secondListName) ?? "Empty List")", destination: CSVListView(watchListCount: $watchListCount, watchList: $watchList,showSettingsView: $showSettingsView, showListView: $showListView, a:$a, b:$b, c:$c, d:$d).environmentObject(controlCenter).onAppear{
                fileName = sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.secondListName) ?? "Empty List"
                watchList = (sharedUserDefaults?.stringArray(forKey:SharedUserDefaults.Keys.secondList) ?? ["Empty"])
                            watchListCount = sharedUserDefaults?.stringArray(forKey:SharedUserDefaults.Keys.secondList)?.count ?? 0               }).font(.footnote)
            
     
                NavigationLink("3. \(sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.thirdListName) ?? "Empty List")", destination: CSVListView(watchListCount: $watchListCount, watchList: $watchList,showSettingsView: $showSettingsView, showListView: $showListView, a:$a, b:$b, c:$c, d:$d).environmentObject(controlCenter).onAppear{
                fileName = sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.thirdListName) ?? "Empty List"
                watchList = (sharedUserDefaults?.stringArray(forKey:SharedUserDefaults.Keys.thirdList) ?? ["Empty"])
                watchListCount = sharedUserDefaults?.stringArray(forKey:SharedUserDefaults.Keys.thirdList)?.count ?? 0
            }).font(.footnote)
            
                    
                NavigationLink("4. \(sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.fourthListName) ?? "Empty List")", destination: CSVListView(watchListCount: $watchListCount, watchList: $watchList,showSettingsView: $showSettingsView, showListView: $showListView, a:$a, b:$b, c:$c, d:$d).environmentObject(controlCenter).onAppear{
                fileName = sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.fourthListName) ?? "Empty List"
                watchList = (sharedUserDefaults?.stringArray(forKey:SharedUserDefaults.Keys.fourthList) ?? ["Empty"])
                watchListCount = sharedUserDefaults?.stringArray(forKey:SharedUserDefaults.Keys.fourthList)?.count ?? 0   
            }).font(.footnote)
            }
        }
            .navigationTitle("Saved Lists")
    }
}

