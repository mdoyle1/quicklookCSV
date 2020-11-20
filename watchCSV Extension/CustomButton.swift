//
//  CustomButtons.swift
//  watchCSV Extension
//
//  Created by Mark Doyle on 11/15/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI

struct CustomButton: View {
    @Binding var currentSelection:String
    @Binding var currentFile:String
    @State var buttonActivity:Color
  
    
   
    var isButtonActive:Bool = false
    var listNumber:String = ""
    @Binding var a:Bool
    @Binding var b:Bool
    @Binding var c:Bool
    @Binding var d:Bool
    @Binding var watchList:[String]
    @Binding var showSettingsView:Bool
    
    var body: some View {
        Button(action:{
            if listNumber == "1" {
                currentSelection = SharedUserDefaults.Keys.firstList
                currentFile = SharedUserDefaults.Keys.firstListName
                a = true
                b = false
                c = false
                d = false
            }
            if listNumber == "2"{
                currentSelection = SharedUserDefaults.Keys.secondList
                currentFile =  SharedUserDefaults.Keys.secondListName
                a = false
                b = true
                c = false
                d = false
            }
            if listNumber == "3"{
                currentSelection = SharedUserDefaults.Keys.thirdList
                currentFile = SharedUserDefaults.Keys.thirdListName
                a = false
                b = false
                c = true
                d = false
            }
            if listNumber == "4"{
                currentSelection = SharedUserDefaults.Keys.fourthList
                currentFile = SharedUserDefaults.Keys.fourthListName
                a = false
                b = false
                c = false
                d = true
            }
            sharedUserDefaults?.setValue(fileName, forKey: currentFile)
            sharedUserDefaults?.setValue(watchList, forKey: currentSelection)
            showSettingsView.toggle()
            print(sharedUserDefaults?.string(forKey:currentFile) ?? "none")
            print(sharedUserDefaults?.stringArray(forKey:currentSelection) ?? "none")
        }){Text(listNumber)}.background(buttonActivity.opacity(0.5)).cornerRadius(20)
     
        }
        
        
    }



