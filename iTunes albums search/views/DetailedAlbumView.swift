//
//  DetailedAlbumView.swift
//  iTunes albums search
//
//  Created by Михаил Вилкин on 07.09.2020.
//  Copyright © 2020 Михаил Вилкин. All rights reserved.
//

import SwiftUI
import URLImage


struct DetailedAlbumView: View {
    
    @ObservedObject var viewModel: SearchAlbumsViewModel
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                
                URLImage(URL(string: viewModel.selectedAlbum!.artworkUrl100)!)
                    .frame(minWidth: 100, idealWidth: 100, maxWidth: 100, minHeight: 100, idealHeight: 100, maxHeight: 100, alignment: .center)
                
                VStack(alignment: .leading) {
                    
                    Text("Album: " + viewModel.selectedAlbum!.collectionName)
                        .bold()
                    Text("Artist: " + viewModel.selectedAlbum!.artistName)
                    Text("Country: " + viewModel.selectedAlbum!.country)
                    Text("Genre: " + viewModel.selectedAlbum!.primaryGenreName)
                    Text("Released: " + viewModel.selectedAlbum!.releaseDate)
                }
            }.padding(20)
            //Text(String(viewModel.selectedAlbum!.songs.count))
            List(viewModel.selectedAlbum!.songs) { song in
                Text(String(song.numberInAlbum) + ". " + song.name).bold()
            }.colorMultiply(Color(.secondarySystemBackground))
            Text("")
        }
    }
}
