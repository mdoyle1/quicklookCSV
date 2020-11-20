//
//  quicklookCSVApp.swift
//  watchCSV Extension
//
//  Created by Mark Doyle on 11/5/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI

@main
struct quicklookCSVApp: App {
    @EnvironmentObject var controlCenter:ControlCenter
    @State var watchList:[String] = []
    @State var csvFileNames:[String] = []
    @State var watchListCount:Int = 0
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(connectivityProvider: ConnectivityProvider(watchList: $watchList, csvFileNames: $csvFileNames, watchListCount: $watchListCount), watchList: $watchList, watchListCount: $watchListCount, csvFileNames: $csvFileNames).environmentObject(ControlCenter())
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
