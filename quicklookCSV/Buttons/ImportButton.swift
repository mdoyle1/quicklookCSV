//
//  ImportButton.swift
//  quicklookCSV
//
//  Created by developer on 5/29/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import Foundation
import SwiftUI

//https://stackoverflow.com/questions/27721418/getting-list-of-files-in-documents-folder/27722526

var file = ""
struct ImportButton: View {
@EnvironmentObject var controlCenter: ControlCenter
@State private var isPresented = false

var body: some View {
Button(action: {
    self.isPresented = true
    emptyArrays(control: self.controlCenter)
    resetBools(control: self.controlCenter)
    self.controlCenter.modifiedTuple = self.controlCenter.initialTuple
    })
{Image(systemName:"folder")}
    .environmentObject(self.controlCenter)
             .buttonStyle(BorderlessButtonStyle())
    .sheet(isPresented: $isPresented, onDismiss: {
        self.controlCenter.showLists = true
        //POPULATE THE NEWLY IMPORTED FILE
        getFiles(control: self.controlCenter, completion: {print("import dismiss")})
    })
      {DocumentPickerViewController().environmentObject(self.controlCenter)}.environmentObject(self.controlCenter)

    }
}

struct DocumentPickerViewController: UIViewControllerRepresentable {
    @EnvironmentObject var controlCenter: ControlCenter
    
    private let supportedTypes: [String] = ["public.comma-separated-values-text"]
    // Callback to be executed when users close the document picker.
    
    func onDismiss(){
//         getFiles(control: controlCenter)
//        print("onDismiss \(controlCenter.recentFiles)")
    }
    init() {
        onDismiss()
    }
    
    typealias UIViewControllerType = UIDocumentPickerViewController
 

    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        @EnvironmentObject var controlCenter: ControlCenter
        @ObservedObject var defaults = Defaults()

        var parent: DocumentPickerViewController
        
        init(documentPickerController:DocumentPickerViewController, controlCenter: EnvironmentObject<ControlCenter>) {
            parent = documentPickerController
            _controlCenter = controlCenter
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
           
            
            //GET THE PATH TO CSV
            controlCenter.globalPathToCsv = url
            //csvToList(control: controlCenter)
            
            
            //GET THE FILENAME FROM THE LAST PATH COMPONENT OF THE URL
            let filename = url.lastPathComponent
            controlCenter.fileName = filename
            print("HERE IS THE FILE: \(controlCenter.fileName)")
           
            
            //COPY FILE TO DOCUMENTS FOLDER
               // let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
           let documentsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents")
                if let documentsURL = documentsURL {
                    let destURL = documentsURL.appendingPathComponent(filename)
                    do { try FileManager.default.copyItem(at: url, to: destURL) } catch {print("Unable to copy files...") }
                }
            
            //importItems(control: self.controlCenter, filename: filename, completion: {print("File Created")})
            
           
          
            getFiles(control: controlCenter, completion: {print("documents fetch")})
            print("onDismiss \(controlCenter.recentFiles)")
            self.defaults.CreateFileDictionary = [filename:url.absoluteString]
            
            //APPEND TO THE USER NEW ARRAYS
            self.defaults.FilePaths.append([filename:url.absoluteString])
            self.defaults.FileNames.append(filename)
            
            //SET THE NEW ARRAY AS THE DEFAULT
            UserDefaults.standard.set(defaults.FilePaths,forKey: "RecentFiles")
            UserDefaults.standard.set(defaults.FileNames, forKey: "FileNames")
            
            //print(UserDefaults.standard.object(forKey: "FileNames"))
            print(self.defaults.FileNames.count)
            
            
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.onDismiss()
            
        }
    }
    
    
    
    
    func makeUIViewController(context: Context) -> DocumentPickerViewController.UIViewControllerType {
        let documentPickerController = UIDocumentPickerViewController(documentTypes: supportedTypes, in: .import)
        documentPickerController.allowsMultipleSelection = false
        documentPickerController.delegate = context.coordinator
        
        
        return documentPickerController
    }
    
    func updateUIViewController(_ uiViewController: DocumentPickerViewController.UIViewControllerType, context: Context) {
       
    }
    
    // MARK: Coordinator
    
    func makeCoordinator() -> DocumentPickerViewController.Coordinator {
        return Coordinator(documentPickerController: self, controlCenter: _controlCenter)
    }
    
}
