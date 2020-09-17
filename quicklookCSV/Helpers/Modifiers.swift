//
//  Modifiers.swift
//  quicklookCSV
//
//  Created by developer on 6/8/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import Foundation
import SwiftUI

struct ButtonFormat: ViewModifier {
    func body(content: Content) -> some View {
        content
            
            .foregroundColor(.primary)
            .padding(.all, 10)
            .background(Color(.gray).opacity(0.3))
            .cornerRadius(10)
            .padding(.all,8)
        
    }

}

