//
//  Logo.swift
//  quicklookCSV
//
//  Created by developer on 6/9/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI

struct Logo: View {
    @EnvironmentObject var controlCenter: ControlCenter
    @State private var animationAmount: CGFloat = 0.5
    @State var blur:CGFloat = 3
    @State var radY:CGFloat = -5
    @State var radX:CGFloat = -2
    var body: some View {
        VStack{
            if self.controlCenter.recentFiles.count != 0 {
                NavigationLink(destination: Help()){
                    HStack{
                        Text("QuicklookCSV").font(.subheadline)
                            .foregroundColor(Color.white).bold()
                            .shadow(color: Color.gray, radius: blur, x: radX, y: radY)
                            .onAppear{
                                let baseAnimation = Animation.easeIn(duration: 10)
                                let repeated = baseAnimation.repeatForever(autoreverses: true)
                                return withAnimation(repeated){
                                    self.blur = 5
                                    self.radY = 5
                                    self.radX = 3
                                }
                        }.padding(.trailing, 10)
                        Image(systemName: "questionmark.circle.fill")
                        
                    }
                }
            } else {
                Text("QuicklookCSV").font(.subheadline)
                    .foregroundColor(Color.white).bold()
                    .shadow(color: Color.gray, radius: blur, x: radX, y: radY)
                    .onAppear{
                        let baseAnimation = Animation.easeIn(duration: 10)
                        let repeated = baseAnimation.repeatForever(autoreverses: true)
                        return withAnimation(repeated){
                            self.blur = 5
                            self.radY = 5
                            self.radX = 3
                        }
                }.padding(.trailing, 10)
                
                
            }
            
        }
    }
}


