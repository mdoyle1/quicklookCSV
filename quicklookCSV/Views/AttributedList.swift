//
//  AttributedList.swift
//  quicklookCSV
//
//  Created by developer on 6/19/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI
import SwiftyAttributes

struct AttributedList: View {
    let jacko = "Hello, World!".withUnderlineColor(.red).withUnderlineStyle(.double)
    var body: some View {
        Text(jacko)
    }
}

struct AttributedList_Previews: PreviewProvider {
    static var previews: some View {
        AttributedList()
    }
}
