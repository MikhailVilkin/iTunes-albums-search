//
//  SearchAlbumsViewModel.swift
//  iTunes albums search
//
//  Created by Михаил Вилкин on 07.09.2020.
//  Copyright © 2020 Михаил Вилкин. All rights reserved.
//

import SwiftUI
import Combine

final class SearchAlbumsViewModel: ObservableObject {
    
    @Published var request = ""
    
    @Published private(set) var albums = [Album]()
    
    @Published var selectedAlbum: Album?
        
    func searchAlbums() {
        
        SearchAlbumsService.shared.getAlbums(searchRequest: request) { (requestedAlbums) in
            
            // Getting albums when it is needed
            DispatchQueue.main.async {
                self.albums = requestedAlbums.sorted(by: {$0.collectionName < $1.collectionName})
            }
        }
        
    }
    
    func clearAlbumsList() {
        albums.removeAll()
    }
}
