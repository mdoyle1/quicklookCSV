//
//  FileSearchBar.swift
//  quicklookCSV
//
//  Created by Mark Doyle on 11/16/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//


import Foundation
import SwiftUI

struct FileSearchBar: UIViewRepresentable {
    
    @Binding var text: String
    
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        
        init(text: Binding<String>) {
            _text = text
            
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            text = searchText
            
        }
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
            searchBar.resignFirstResponder()
            
        }
        
        
    }
    
    
    
    func makeCoordinator() -> FileSearchBar.Coordinator {
        return Coordinator(text: $text)
        
    }
    
    func makeUIView(context: UIViewRepresentableContext<FileSearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.returnKeyType = .search
        searchBar.delegate = context.coordinator
        searchBar.backgroundImage = UIImage()
//        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = .default
        searchBar.placeholder = "Search..."
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<FileSearchBar>) {
        uiView.text = text
        
    }
    
    
}


