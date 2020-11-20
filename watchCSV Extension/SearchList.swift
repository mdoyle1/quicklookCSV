//
//  SearchList.swift
//  watchCSV Extension
//
//  Created by Mark Doyle on 11/15/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI

struct SearchList: View {
    @Binding var watchList:[String]
    @Binding var searchText:String
    @Binding var newSearchList:[String]
    
    func removeItems(at offsets: IndexSet){
        let itemIndex:Int = offsets.first!
        print("Delete")
        
  
        watchList = watchList.filter{ $0 != newSearchList[itemIndex] }
       
        newSearchList.remove(at: itemIndex)
    }
    
    var body: some View {
   
        ForEach(newSearchList, id:\.self) { item in
         
                Text(item.dropLast(2)).padding()
            
        }.onDelete(perform: removeItems)
        
      
    
        
}

}
