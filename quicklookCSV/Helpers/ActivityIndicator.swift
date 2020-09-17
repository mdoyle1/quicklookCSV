//
//  ActivityIndicator.swift
//  quicklook
//
//  Created by Toxicspu on 3/31/20.
//  Copyright © 2020 developer. All rights reserved.
//

import SwiftUI

//https://stackoverflow.com/questions/56496638/activity-indicator-in-swiftui
//https://www.youtube.com/watch?v=IQ4cuotho-U


struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView<Content>: View where Content: View {
    @EnvironmentObject var controlCenter:ControlCenter
    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    Text(self.controlCenter.loadingText)
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height)
                .border(Color.clear, width: 2)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }

}
