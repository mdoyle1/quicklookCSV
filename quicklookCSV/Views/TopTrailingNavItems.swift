//
//  TopTrailingNavItems.swift
//  quicklookCSV
//
//  Created by developer on 6/5/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI

struct BottomNavItems: View {
    @EnvironmentObject var controlCenter: ControlCenter
    var body: some View {
        HStack{
            HStack{
                Text("Total: ").font(.custom("courier", size: 14))
          Text("\(self.controlCenter.arrayCount)").font(.custom("courier", size: 14))
            }
            Spacer()
            ExportButton()
        }
        
    }
}


