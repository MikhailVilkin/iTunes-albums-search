//
//  AlbumRowView.swift
//  iTunes albums search
//
//  Created by Михаил Вилкин on 07.09.2020.
//  Copyright © 2020 Михаил Вилкин. All rights reserved.
//

import SwiftUI
import URLImage

struct AlbumRow: View {
    
    @ObservedObject var viewModel: SearchAlbumsViewModel
    @State var album: Album
    
    var body: some View {
        
        HStack {
            
            URLImage(URL(string: album.artworkUrl100)!)
                .frame(minWidth: 100, idealWidth: 100, maxWidth: 100, minHeight: 100, idealHeight: 100, maxHeight: 100, alignment: .center)
            VStack(alignment: .leading) {
                Text(album.collectionName)
                    .bold().frame(alignment: .leading)
                Text(album.artistName).frame(alignment: .leading)
            }
            Spacer()
        }.padding(20)
    }
}
