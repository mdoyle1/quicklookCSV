//
//  InitializerFunctions.swift
//  quicklookCSV
//
//  Created by developer on 8/6/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import Foundation
//INITIALIZATION FUNCTIONS
func initializeItems (control: ControlCenter){
    control.globalPathToCsv = URL(string: "")
    control.searchTerm = ""
    control.fileName = ""
    control.loadingText = "Loading..."
    control.csvArray.removeAll()
    control.initialList.removeAll()
    control.modifiedList.removeAll()
    control.headers.removeAll()
    control.selectedHeaders.removeAll()
    control.modifiedTuple.removeAll()
    control.initialTuple.removeAll()
    control.itemToAdd.removeAll()
    control.AddItem.removeAll()
    control.showHeaders = false
    control.showInitialList = true
    if control.selectedHeaders == [] {
        control.listIsModified = false}
    else {control.listIsModified = true}
}
func emptyArrays (control:ControlCenter){
    //EMPTY ARRAYS
    control.initialList.removeAll()
    control.modifiedList.removeAll()
    control.headers.removeAll()
    control.selectedHeaders.removeAll()
    control.modifiedTuple.removeAll()
    control.initialTuple.removeAll()
    control.updatedHeaderNames.removeAll()
    control.AddItem.removeAll()
}

func resetBools(control: ControlCenter){
    // control.firstTimeFlatteningList = true
    control.newFileIsActive = false
    control.isActive = false
    control.newItemView = false
    control.AddItemDidView = false
    control.showChangeHeaderName = false
    control.ShowStateArray = false
    control.cloudFile = false
    control.firstTimeEditingHeaders = true
    control.returnFromSave = false
    control.itemDidView = false
    control.itemViewIsShowing = false
    control.showHeaders = false
    control.showLists = false
    control.showInitialList = true
    control.headersViewAccessed = false
    control.returnFromItemSelection = false
    if control.selectedHeaders == [] {
        control.listIsModified = false
    } else {
        control.listIsModified = true
    }
}
