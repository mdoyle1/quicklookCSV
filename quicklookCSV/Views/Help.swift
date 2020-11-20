//
//  Help.swift
//  quicklookCSV
//
//  Created by developer on 6/9/20.
//  Copyright © 2020 Toxicspu. All rights reserved.
//

import SwiftUI

struct Help: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Group{
                    Text("About").font(.title).bold().underline().padding(.bottom, 8)
                   // Text("iOS 13+").font(.subheadline)
                    HStack{
                        Text("contact:").font(.subheadline).bold().italic().padding(.bottom, 15)
                    Text("quicklookcsv@gmail.com").font(.subheadline).foregroundColor(.blue).italic().underline().padding(.bottom, 15).onTapGesture() {
                        UIApplication.shared.open(URL(string: "mailto:quicklookcsv@gmail.com")!)
                    }
                    }
                    VStack(alignment:.leading){
                        Text("""
Use string searching to quickly find specific data within a CSV. Perform various functions to help narrow down your search, export and share data. Quicklook works with a flat CSV database containing headers and rows. The headers must be in the first row followed by additional rows.
""").font(.subheadline)
                        HStack{Spacer()}
                    }
                    .padding(.all, 10)
                    .background(Color(.gray).opacity(0.2))
                    .cornerRadius(10)
                    
                        
                    
//                    Group{
//
//                        VStack(alignment:.leading){
//                            Text("Here's what you can do...").font(.system(size: 24)).font(.headline).bold().italic().underline().padding(.bottom, 10)
//                    VStack(alignment: .leading){
//
//                        HStack(spacing: 10) {
//                            Text("\u{2022}").bold()
//                            Text("Search & Customize CSVs").bold()
//                        }
//                        HStack(spacing: 10) {
//                            Text("\u{2022}").bold()
//                            Text("Extrapolate CSV data").bold()
//                        }
//                        HStack(spacing: 10) {
//                            Text("\u{2022}").bold()
//                            Text("Scan barcode to search").bold()
//                        }
//                        HStack(spacing: 10) {
//                            Text("\u{2022}").bold()
//                            Text("Save and Share Searches").bold()
//                        }
//                        HStack(spacing: 10) {
//                            Text("\u{2022}").bold()
//                            Text("Sync with iCloud").bold()
//                        }
//                        HStack{Spacer()}
//                    }
//              .padding(.leading, 20)
//
//                        }
//
//
//                        .padding(.all, 10)
//                                      .background(Color(.gray).opacity(0.3))
//                                      .cornerRadius(10)
//                    }
                    
                    
//                    VStack(alignment:.leading){
//                        Text("Find some interesting data here.").bold().padding(.init(top: 10, leading: 10, bottom: 0, trailing: 0))
//                        VStack{
//                            Text("https://catalog.data.gov/dataset")
//                                .font(.subheadline).foregroundColor(.blue).italic().underline().onTapGesture() {
//                                    UIApplication.shared.open(URL(string: "https://catalog.data.gov/dataset")!)
//                            }
//
//                        }
//                        .padding(.all, 10)
//                        .background(Color(.systemBackground))
//                        .cornerRadius(10)
//                        .padding(.all, 10)
//
//                        Text("Get started with this tutorial!").bold().padding(.init(top: 10, leading: 10, bottom: 0, trailing: 0))
//                        VStack(alignment: .leading){
//                            Text("Begin Searching!")
//                                .font(.subheadline).foregroundColor(.blue).italic().underline().onTapGesture() {
//                                    UIApplication.shared.open(URL(string: "https://youtu.be/UwNd5Hz80yY")!)
//                            }
//
//                            Text("Scan Barcode to Search.")
//                                .font(.subheadline).foregroundColor(.blue).italic().underline().onTapGesture() {
//                                    UIApplication.shared.open(URL(string: "https://youtu.be/ZpC7eikbXBU")!)
//                            }
//
//                        }
//                                             .padding(.all, 10)
//                                             .background(Color(.systemBackground))
//                                             .cornerRadius(10)
//                         .padding(.all, 10)
//                        HStack{Spacer()}
//
//                    }
                   // .padding(.all, 10)
//                    .background(Color(.gray).opacity(0.1))
//                    .cornerRadius(10)
                }
                    Group{
                    HStack{
                        
                        Image(systemName: "folder").font(.title)
                        Text("Document Browser").font(.title)
                    }
                    Text("By clicking on the folder icon document browser will open and you can begin importing CSVs.  You can also share files by using Apple's built in 3D touch feature “peek and pop”.").padding(.bottom, 10)
                        
                        HStack{
                            Image(systemName: "plus.square").font(.title)
                            Text("New CSV").font(.title)
                        }
                        Text("Create a new CSV by specifying headers.  After headers are created add content by pressing the + sign on the footer bar of the list view.").padding(.bottom, 10)

                    HStack{
                        Image(systemName: "circle.fill").font(.title)
                        Text("Local Files").font(.title)
                    }
                     Text("Files marked with a filled circle are available locally on your device.").padding(.bottom, 10)
                        
                    HStack{
                        Image(systemName: "circle").font(.title)
                        Text("Cloud Files").font(.title)
                    }
                     Text("Files marked with an empty circle are still in the cloud and will be synced when opening or pulling the file list down.").padding(.bottom, 10)
                        
                    
                    HStack{
                        Image(systemName: "rectangle.split.3x1").font(.title)
                        Text("Headers").font(.title)
                    }
                       Text("After opening a file you can begin searching its contents using the search bar. You can specify which columns to view by pressing the headers button.").padding(.bottom, 10)
                    }
                Group{
                    HStack{
                        Image(systemName: "pencil.circle").font(.title)
                        Text("Modify Header").font(.title)
                    }
                    Text("While in the Column / Header selection view you can also modify header names by pressing the pencil with the circle with pencil.  For example, you could change Barcode to Asset Tag and Asset Serial No to Serial.  This is handy when CSVs are used for importing data to servers through scripts or applications that require specific header names on the CSV.").padding(.bottom, 10)
                    
                    HStack{
                        Image(systemName: "pencil.circle.fill").font(.title)
                        Text("Restore Header").font(.title)
                    }
                    Text("When a header is modified the circle will be filled in. You can change the header back to its default state by pressing the modify header button again.  The default header value will be displayed in the text field.  Press the check box next to the text field and the header will be restored.").padding(.bottom, 10)
                    HStack{
                        Text("A").font(.custom("courier", size: 40)).bold()
                        Text("Case Sensitivity").font(.title)
                    }
                    Text("Toggle the A to turn case sensitivity on/off.  'A' performs a case sensitive search, 'a' will perform a case in-sensitive search.").padding(.bottom, 10)
                    HStack{
                        Image(systemName: "pin").font(.title)
                        Text("Save List").font(.title)
                    }
                    Text("If you have search results you would like to export you can touch the pin and save the search results to a new file.").padding(.bottom, 10)
                    
                }
                Group{
                    HStack{
                        Image(systemName: "rectangle.compress.vertical").font(.title)
                        Text("Truncate List").font(.title)
                    }
                    Text("You can truncate search results and search new strings limited to the previous search. This is a non-destructive function that won’t affect the original CSV but is useful for narrowing down a search.").padding(.bottom, 10)
                    HStack{
                        Image(systemName: "plus").font(.title)
                        Text("Add Item").font(.title)
                    }
                    Text("Add new items to your list.  You must save the list using the Pin to keep any additions.").padding(.bottom, 10)
                    HStack{
                        Image(systemName: "square.and.arrow.up").font(.title)
                        Text("Share Item").font(.title)
                    }
                    Text("Quickly share specific row items.  If you press an item in your CSV list you will be taken to the item view and the share button will be displayed.").padding(.bottom, 10)
                    HStack{
                        Image(systemName: "doc.on.clipboard.fill").font(.title)
                        Text("Paste to Search").font(.title)
                    }
                    Text("Within item view each header will be displayed with its associated value.  If you press any key / value pair in this view the value will be copied to the pasteboard.  Paste the value into the search bar by pressing the paste button located next to the search bar. The value is copied to the iOS pasteboard so you can paste the value into any field. ").padding(.bottom, 10)
                }
                Group{
                    
                    HStack{
                        Image(systemName: "barcode").font(.title)
                        Text("Barcode Scanner").font(.title)
                    }
                    Text("Scan barcodes into the Search Bar or into new textfields when creating lists by pressing and holding on the textfield to bring up a context menu presenting the Barcode Scanner.").padding(.bottom, 10)
                  
                    HStack{
                        Image(systemName: "doc.text.viewfinder").font(.title)
                        Text("Text Scanner").font(.title)
                    }
                    Text("Image to text is available by pressing and holding on the Search Bar textfield or an Add Item text field.").padding(.bottom, 10)
                    
                    HStack{
                        Image(systemName: "applewatch").font(.title)
                        Text("WatchOS").font(.title)
                    }
                    Text("Press to force sync a list to your apple watch.  Lists will be automatically sync when opened unless the iOS list is open before the watchOS app.  Press the Apple Watch icon to push the list again.").padding(.bottom, 10)
                }
                
            }
           
            .padding(.all, 10)
            .background(Color(.gray).opacity(0.2)).cornerRadius(10)
            .padding(.all, 10)
           
            
            
                .navigationBarTitle("Getting Started")
        }
    }
}
