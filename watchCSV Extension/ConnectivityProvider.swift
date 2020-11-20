//
//  ConnectivityProvider.swift
//  watchCSV Extension
//
//  Created by Mark Doyle on 11/5/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//


import Foundation
import SwiftUI
import WatchConnectivity

var text = ""
var fileName:String?


class ConnectivityProvider: NSObject, WCSessionDelegate {

    @EnvironmentObject var controlCenter:ControlCenter
    @Binding var watchList:[String]
    @Binding var csvFileNames:[String]
    @Binding var watchListCount:Int
    private let session: WCSession

    init(session: WCSession = .default, watchList: Binding<[String]>, csvFileNames: Binding<[String]>, watchListCount:Binding<Int>) {
       
        print("initialized")
        self.session = session
        _watchList = watchList
        _csvFileNames = csvFileNames
        _watchListCount = watchListCount
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
        print(message["search"] ?? "")
        //csvFileNames.removeAll()
        
        //MARK:- GET FILE NAMES FROM IPHONE
        var fileNames: [String] = [""]
        fileNames = message["names"] as? [String] ?? []
        csvFileNames = fileNames
        print(csvFileNames)

        
        
        //MARK:- GET LIST DATA FROM IPHONE
        var dict: Dictionary<String,[String]> = [:]
        dict = message["search"] as? Dictionary<String, [String]> ?? [:]
        for (key, value) in dict {
            fileName = key.description
            watchList = value
            watchListCount += 1
        }

       
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


final class sharedData: ObservableObject {

    private(set) var connectivityProvider: ConnectivityProvider
    var textFieldValue: String = ""
    @EnvironmentObject var controlCenter:ControlCenter

    init(connectivityProvider: ConnectivityProvider) {
        self.connectivityProvider = connectivityProvider
        
    }
 
    func sendMessage() -> Void {
        let txt = textFieldValue
        let message = ["message":txt]
        connectivityProvider.connect()
        connectivityProvider.send(message: message)
    }
}
