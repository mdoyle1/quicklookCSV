//
//  SharedUserDefaults.swift
//  quicklookCSV
//
//  Created by Mark Doyle on 11/5/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import Foundation

struct SharedUserDefaults {
    static let suiteName = "group.com.toxicpsu.quicklookCSV"
    struct Keys {
        static let savedLists = "savedLists"
        static let firstList = "firstList"
        static let firstListName = "firstListName"
        static let secondList = "secondList"
        static let secondListName = "secondListName"
        static let thirdList = "thirdList"
        static let thirdListName = "thirdListName"
        static let fourthList = "fourthList"
        static let fourthListName = "fourthListName"
    }
}
let sharedUserDefaults = UserDefaults(suiteName: SharedUserDefaults.suiteName)
