//
//  Zoom.swift
//  quicklookCSV
//
//  Created by developer on 6/1/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import Foundation
import SwiftUI

struct ZoomIN:View {
    @EnvironmentObject var controlCenter: ControlCenter
    var body: some View{
        HStack{
            Button(action: {
                if self.controlCenter.itemViewIsShowing == false{
                    if self.controlCenter.fontSize <= 20 {
                        self.controlCenter.fontSize += 2}
                }else {
                    if self.controlCenter.itemFontSize <= 50 {
                        self.controlCenter.itemFontSize += 2}
                }
            }){Image(systemName: "plus.magnifyingglass").font(.system(size: 30))}
        }
    }
}

struct ZoomOUT:View {
    @EnvironmentObject var controlCenter: ControlCenter
    var body: some View{
        HStack{
            Button(action: {
                if self.controlCenter.itemViewIsShowing == false{
                if self.controlCenter.fontSize >= 8{
                    self.controlCenter.fontSize -= 2}
                }else {
                    if self.controlCenter.itemFontSize >= 12 {
                        self.controlCenter.itemFontSize -= 2
                    }
                }
                }) {Image(systemName: "minus.magnifyingglass").font(.system(size: 30))}
        }
    }
}
