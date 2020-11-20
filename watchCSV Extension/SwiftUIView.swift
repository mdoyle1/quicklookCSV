//
//  SwiftUIView.swift
//  quicklookCSV
//
//  Created by Mark Doyle on 11/5/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//
//
//import SwiftUI
//
//
//
//var addList:[String] = []
//
//struct SwiftUIView: View {
//    @Binding var listView:Bool
//    @State var showWarning:Bool = false
//    @State var showList:Bool = false
//    
//    var firstList:[String]?
//    
//    @State var key1 = SharedUserDefaults.Keys.firstList
//    
//    @State var name1 = SharedUserDefaults.Keys.firstListName
//
//
//    @State var firstListName = sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.firstListName)
//    @State var secondListName = sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.secondListName)
//    @State var thirdListName = sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.thirdListName)
//    @State var fourthListName = sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.fourthListName)
//
//    @State var arrayOfDefaults = [sharedUserDefaults?.stringArray(forKey:SharedUserDefaults.Keys.firstList), sharedUserDefaults?.stringArray(forKey:SharedUserDefaults.Keys.secondList), sharedUserDefaults?.stringArray(forKey:SharedUserDefaults.Keys.thirdList), sharedUserDefaults?.stringArray(forKey:SharedUserDefaults.Keys.fourthList)]
//
//    @State var arrayOfKeys = [SharedUserDefaults.Keys.firstList, SharedUserDefaults.Keys.secondList, SharedUserDefaults.Keys.thirdList, SharedUserDefaults.Keys.fourthList]
//    var arrayOfNames = [SharedUserDefaults.Keys.firstListName, SharedUserDefaults.Keys.secondListName, SharedUserDefaults.Keys.thirdListName, SharedUserDefaults.Keys.fourthListName]
//    @State var arrayOfListNames = [sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.firstListName), sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.secondListName), sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.thirdListName), sharedUserDefaults?.string(forKey:SharedUserDefaults.Keys.fourthListName)]
//    
//    func removeItems(at offsets: IndexSet){
//        let itemIndex:Int = offsets.first!
//        print("Delete")
//       // print(controlCenter.urlFileNames[itemIndex])
//       // controlCenter.recentFiles = controlCenter.recentFiles.sorted(by: {$0.absoluteString < $1.absoluteString} )
//        print(arrayOfListNames[itemIndex])
//        print(arrayOfDefaults[itemIndex])
//        sharedUserDefaults?.setValue(nil, forKey: arrayOfKeys[itemIndex])
//        sharedUserDefaults?.setValue(nil, forKey: arrayOfNames[itemIndex])
//        arrayOfListNames.remove(at: itemIndex)
//       // arrayOfDefaults[itemIndex] = []
//        //controlCenter.recentFiles.remove(at: itemIndex)
//        //controlCenter.urlFileNames.remove(at:itemIndex)
//    }
//    
//    
//    var body: some View {
//       // if listView == false {
//        ScrollView{
//            ForEach(0..<arrayOfDefaults.count){ i in
//            
//                if arrayOfDefaults[i]?.count == 0 {
//                    NavigationLink("******", destination: NewListView())
//                } else {
//                    NavigationLink(arrayOfListNames[i] ?? "", destination: NewListView())
//                }
//                
//            }
//            
//        VStack{
//        Text("Please make sure Watch is paired, then create a list or open a CSV with quicklookCSV on your iPhone.")
//      //MARK:- SET DEFAULTS
//        Button(action:{
//            print(firstList?.count)
//            print(secondList?.count)
//            print(thirdList?.count)
//            print(fourthList?.count)
//            var z = 0
////            if firstList?.count == 0 || firstList?.count == nil || secondList?.count == 0 || secondList?.count == nil || thirdList?.count == 0 || thirdList?.count == nil || fourthList?.count == 0 || fourthList?.count == nil {
//                outerLoop: for x in 0..<arrayOfDefaults.count {
//                
//                    if arrayOfDefaults[x]?.count == 0 || arrayOfDefaults[x]?.count == nil{
//                        z+=1
//                        sharedUserDefaults?.setValue(arrayAny, forKey: arrayOfKeys[x])
//                        sharedUserDefaults?.setValue(fileName?.description, forKey: arrayOfNames[x])
//                        showList = true
//                        print(arrayAny)
//                        print(fileName?.description)
//                        print(sharedUserDefaults?.stringArray(forKey: arrayOfKeys[x]))
//                       // listView.toggle()
//                        break outerLoop
//                    } else {
//                        
//                    }
//                }
//               
//            }
////        else {
////               // Warning message only allowed to store 4 lists.  Please clear one...
////               showWarning = true
////            }
//           // }
//        ){Text("Sync")}
//        }
//       // }
//        if showWarning {
//            Text("Only 4 lists can be loaded at once.  Please clear an exiting list.")
//            List{
//            ForEach(arrayOfListNames, id: \.self){ name in
//                Text(name?.description ?? "Cleared")
//            }.onDelete(perform: self.removeItems)
//            }}
//        
//    
//    }
//    }}
//
//
