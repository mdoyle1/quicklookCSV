//
//  SearchBar.swift
//  quicklookCSV
//
//  Created by developer on 5/27/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

//https://www.hackingwithswift.com/articles/210/how-to-fix-slow-list-updates-in-swiftui
//https://www.youtube.com/watch?v=4_uP61b0d1E

import Foundation
import SwiftUI


struct SearchBar: UIViewRepresentable {
    @EnvironmentObject var controlCenter: ControlCenter
    @Binding var text: String
    @Binding var array: [String]
    
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @EnvironmentObject var controlCenter: ControlCenter
        @Binding var text: String
        @Binding var array: [String]
        @State var showsCancelButton:Bool = false
        
        init(text: Binding<String>, array: Binding<[String]>, controlCenter: EnvironmentObject<ControlCenter>) {
            _text = text
            _array = array
            _controlCenter = controlCenter
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            text = searchBar.text ?? ""
            controlCenter.ShowStateArray = true
            controlCenter.showInitialList = false
            controlCenter.searchTerm = text
            if self.controlCenter.selectedHeaders == [] {
               
                //CASE SENSITIVE
                if controlCenter.isCaseSensitive {
                    self.array = self.controlCenter.initialList.filter {
                        self.text.isEmpty ? true : (($0.contains(self.text)))}
                    self.controlCenter.arrayCount=self.array.count
                    print(self.array.count)
                }
                    //CASE INSENSITIVE
                else {
                    self.array = self.controlCenter.initialList.filter {
                        self.text.isEmpty ? true : (($0.localizedCaseInsensitiveContains(self.text)))}
                    self.controlCenter.arrayCount=self.array.count
                    print(self.array.count)
                }
                
                //MODIFIED LISTS
            }else {
                //CASE SENSITIVE
                if controlCenter.isCaseSensitive {
                    self.array = self.controlCenter.modifiedList.filter {
                        self.text.isEmpty ? true : (($0.contains(self.text)))}
                    self.controlCenter.arrayCount=self.array.count
                    print(self.controlCenter.arrayCount)
                }
                //CASE INSENSITIVE
                else {
                    self.array = self.controlCenter.modifiedList.filter {
                        self.text.isEmpty ? true : (($0.localizedCaseInsensitiveContains(self.text)))}
                    self.controlCenter.arrayCount=self.array.count
                    print(self.controlCenter.arrayCount)
                }
            }
         
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            self.showsCancelButton = true
        }
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            
        
//            if text == "" {
//                if self.controlCenter.selectedHeaders == [] {
//                    self.array = self.controlCenter.initialList
//                    self.controlCenter.arrayCount=self.array.count
//                }else{
//                    self.array = self.controlCenter.modifiedList
//                    self.controlCenter.arrayCount=self.array.count
//                }
//
//            }
        }
        
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            
            text = ""
            array = []
            controlCenter.searchTerm = ""
            controlCenter.filteredString = self.text
            //self.controlCenter.selectedHeaders.removeAll()
            self.controlCenter.showInitialList = true
            self.controlCenter.arrayCount = self.controlCenter.initialList.count
            self.array.removeAll()
            self.controlCenter.ShowStateArray = false
//            if self.controlCenter.selectedHeaders == [] {
//                self.array = self.controlCenter.initialList
//                self.controlCenter.arrayCount=self.array.count
//            }else{
//                self.array = self.controlCenter.modifiedList
//                self.controlCenter.arrayCount=self.array.count
//            }
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text?.count == 0 {
                text = ""
                controlCenter.searchTerm = ""
                controlCenter.ShowStateArray = false
            
            }
        
        }
        
      
        
        func searchBar(_ searchBar: UISearchBar) {
            
                      text = searchBar.text ?? ""
            controlCenter.ShowStateArray = true
                      controlCenter.showInitialList = false
                      controlCenter.searchTerm = text
                      if self.controlCenter.selectedHeaders == [] {
                         
                          //CASE SENSITIVE
                          if controlCenter.isCaseSensitive {
                              self.array = self.controlCenter.initialList.filter {
                                  self.text.isEmpty ? true : (($0.contains(self.text)))}
                              self.controlCenter.arrayCount=self.array.count
                              print(self.array.count)
                          }
                              //CASE INSENSITIVE
                          else {
                              self.array = self.controlCenter.initialList.filter {
                                  self.text.isEmpty ? true : (($0.localizedCaseInsensitiveContains(self.text)))}
                              self.controlCenter.arrayCount=self.array.count
                              print(self.array.count)
                          }
                          
                          //MODIFIED LISTS
                      }else {
                          //CASE SENSITIVE
                          if controlCenter.isCaseSensitive {
                              self.array = self.controlCenter.modifiedList.filter {
                                  self.text.isEmpty ? true : (($0.contains(self.text)))}
                              self.controlCenter.arrayCount=self.array.count
                              print(self.controlCenter.arrayCount)
                          }
                          //CASE INSENSITIVE
                          else {
                              self.array = self.controlCenter.modifiedList.filter {
                                  self.text.isEmpty ? true : (($0.localizedCaseInsensitiveContains(self.text)))}
                              self.controlCenter.arrayCount=self.array.count
                              print(self.controlCenter.arrayCount)
                          }
                      }

        }
        
    }
    
    
    
    func makeCoordinator() -> SearchBar.Coordinator {
        
        return Coordinator(text: $text, array: $array, controlCenter: _controlCenter)
        
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        
        let searchBar = UISearchBar(frame: .zero)
        
        searchBar.delegate = context.coordinator
        // context.coordinator.searchBarCancelButtonClicked(searchBar)
        searchBar.backgroundImage = UIImage()
        searchBar.showsCancelButton = true
        searchBar.text = self.controlCenter.searchTerm
        searchBar.searchBarStyle = .default
        searchBar.placeholder = "Search..."
        
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
        
        
    }
    
    
}


extension UIApplication {
    func endEditingFirstResponder() {
         sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     }
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        
        return modifier(ResignKeyboardOnDragGesture())
    }
}
