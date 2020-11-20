//
//  ControlCenter.swift
//  quicklookCSV
//
//  Created by developer on 5/27/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

var currentArray:[String] = []
struct CSVData {
    var id = UUID()
    var Items: [String:String]
}

struct RecentFiles {
      var dictionary:[String:String]
  }

struct LocalCloudFiles: Identifiable, Hashable {
    var id = UUID()
    var url:URL
    var file:String
    var cloud: Bool
}

struct CSVItems: Identifiable, Hashable {
    var id = UUID()
    var key:String
    var value:String
}

class ControlCenter: ObservableObject {
    
    @Published var initialTuple: [[(key: String, value: String)]] = [[]]
    @Published var modifiedTuple:[[(key: String, value: String)]] = [[]]
    
    @Published var headers:[String] = []
    @Published var newHeaders:[String] = []
    
    @Published var csvArray: [[String:String]] = [[:]]

    
    @Published var selectedHeaders:[String] = []
    @Published var exportItems:[String] = []

    @Published var arrayOfData = [CSVData]()
    
    @Published var searchTerm:String = ""
    @Published var showsCancelButton:Bool = false
    
    @Published var showLists: Bool = true
    @Published var listIsModified = false
    @Published var showHeaders:Bool = false
   // @Published var firstLoad = true
    @Published var showInitialList = true
    
    
    @Published var modifiedList: [String] = []
    var initialList:[String] = []
    
    
    @Published var currentItem:String = ""
  
    @Published var array: [String] = []
   
    
    @Published var fileName:String = ""
    
    @Published var fontSize:CGFloat = 12
    @Published var itemFontSize:CGFloat = 14
    
    @Published var filteredString = ""
    
    @Published var files = UserDefaults.standard.array(forKey: "FileNames") as? [String] ?? []
    @Published var recentFiles:[URL] = []
    @Published var urlFileNames:[LocalCloudFiles] = [(LocalCloudFiles)]()
    @Published var sortedFiles:[LocalCloudFiles] = [(LocalCloudFiles)]()
    
    @Published var cloudKeys: [String] = []
    @Published var cloudValues: [Bool] = []
 
    @Published var headersViewAccessed = false
    @Published var returnFromItemSelection = false
    
    @Published var itemViewIsShowing = false
    @Published var itemDidView = false
    
    @Published var arrayCount:Int = 0
    @Published var loading: Bool = false
    @Published var listIsLoaded:Bool = false
    @Published var selection:String? = nil
    
    @Published var globalPathToCsv:URL!
    @Published var csvItem:URL!
    
    @Published var returnFromSave:Bool = false
    
    
    @Published var fileDisplay:String = ""
    
    
    @Published var updatedHeaderNames:Dictionary = Dictionary<String, String>()
    
    @Published var headerToChange:String = ""
    @Published var originalHeaders:[String] = []
    @Published var currentItemIndex:Int = 0
    @Published var showChangeHeaderName:Bool = false
    @Published var firstTimeEditingHeaders:Bool = true
    
    
    @Published var cloudFile:Bool = false
    
    @Published var headerRow:String = String()
    @Published var itemArray:[String] = []
    
    @Published var CSVItemsArray:[[CSVItems]] = [[]]
    @Published var showHelp:Bool = false
    
    @Published var isCaseSensitive = true
    @Published var updatedList:[String] = []
    @Published var headerKey:String = String()
    
    //MARK: - LOADING STATES
    @Published var loadingText:String = ""
    @Published var ShowStateArray = false

    @Published var saveFileName:String = ""
 
    
    
    
    //MARK: - ADD ITEM
    @Published var AddItemViewIsShowing:Bool = false
    @Published var AddItemDidView:Bool = false
    @Published var AddItem:Dictionary = Dictionary<String, String>()
    @Published var itemToAdd: [(key: String, value: String)] = []
    
    @Published var newItemView:Bool = false
    
    //MARK: - ACTIVE VIEWS
    @Published var newFileIsActive:Bool = false
    @Published var isActive:Bool = false

    
    @Published var currentKey:String = ""
    @Published var scannedText:String = ""
    @Published var isShowingScanner = false
    @Published var addItemTextScan = false
    
    @Published var currentArray:[String] = []
    @Published var currentString:String = ""
    
    @Published var watchList:[String] = []
}
