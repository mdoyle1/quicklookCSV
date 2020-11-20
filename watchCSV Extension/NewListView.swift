//
//  NewListView.swift
//  watchCSV Extension
//
//  Created by Mark Doyle on 11/10/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI

struct NewListView: View {
    
    var body: some View {
        List{
        ForEach(arrayAny, id:\.self) { item in
            Text(item.dropLast(2)).padding()
        }
        .navigationTitle(fileName ?? "")
        }
    }
}


