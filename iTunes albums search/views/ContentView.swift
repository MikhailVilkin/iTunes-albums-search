//
//  ContentView.swift
//  iTunes albums search
//
//  Created by Михаил Вилкин on 07.09.2020.
//  Copyright © 2020 Михаил Вилкин. All rights reserved.
//

import SwiftUI

// The main view
struct ContentView: View {
    
    @ObservedObject var viewModel = SearchAlbumsViewModel()
    @State private var albumDetailShown = false
    
    var body: some View {
        
        ZStack {
            VStack {
                
                // Search bar
                SearchBar(viewModel: self.viewModel, text: $viewModel.request) {
                    
                    self.viewModel.searchAlbums()
                }
                
                // List of founded albums
                List(viewModel.albums) { album in
                    
                    Button(action: {
                        self.albumDetailShown = true
                        self.viewModel.selectedAlbum = album
                    }) {
                        AlbumRow(viewModel: self.viewModel, album: album)
                    }
                    .buttonStyle(PlainButtonStyle()) // To show the images inside buttons
                }
                .navigationBarTitle(Text("Found Albums:"))
               
            }
            
            // Detailed view of an album
            BottomSheetView(
                isOpen: self.$albumDetailShown,
                maxHeight: UIScreen.main.bounds.size.height - 50
            ) {
                if viewModel.selectedAlbum != nil {
                    
                    DetailedAlbumView(viewModel: self.viewModel)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
