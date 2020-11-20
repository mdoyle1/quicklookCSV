//
//  ConnectivityProvider.swift
//  quicklookCSV
//
//  Created by Mark Doyle on 11/5/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

//https://augmentedcode.io/2020/02/16/fetching-and-displaying-data-on-watch-app-in-swiftui/
import Foundation
import SwiftUI
import WatchConnectivity


class ConnectivityProvider: NSObject, WCSessionDelegate {
    @EnvironmentObject var controlCenter:ControlCenter
    @State var text = String()
    private let session: WCSession

    init(session: WCSession = .default) {
        print("initialized")
        self.session = session
        super.init()
        self.session.delegate = self
        self.connect()
    }

    func send(message: [String:Any]) -> Void {

        session.sendMessage(message, replyHandler: nil) { (error) in
            print(error.localizedDescription)
        }
    }
    


    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("SOTS")

    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("Shit")
        print(message)
        print(message["string"] ?? "")

    }
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        // code
    }

    func sessionDidDeactivate(_ session: WCSession) {
        print("Notosz")
        self.session.activate()
    }
    #endif
    func connect() {
        guard WCSession.isSupported() else {
            print("WCSession is not supported")
            return
        }

        session.activate()
    }
}


final class ViewModel: ObservableObject {
    @ObservedObject var viewModel = Defaults()


    private(set) var connectivityProvider: ConnectivityProvider
    var textFieldValue: String = ""

    init(connectivityProvider: ConnectivityProvider) {
        self.connectivityProvider = connectivityProvider
       
    }

    func sendList() -> Void {
        print("Stacch")
        print(currentArray)
        let message = ["search":[fileName:currentArray]]
        connectivityProvider.connect()
        connectivityProvider.send(message: message)
        
    }
    
    func sendListNames() -> Void {
        print("Names")
        
        let message = ["names":listOfFileNames]
        connectivityProvider.connect()
        connectivityProvider.send(message: message)
        
    }
}
