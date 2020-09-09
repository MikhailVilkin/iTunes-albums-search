//
//  Album.swift
//  iTunes albums search
//
//  Created by Михаил Вилкин on 07.09.2020.
//  Copyright © 2020 Михаил Вилкин. All rights reserved.
//

import Foundation

class Album {
    
    var songs = [Song]()
    
    let artistName: String
    private(set) var artworkUrl100: String
    let collectionId: Int
    let collectionName: String
    let country: String
    let primaryGenreName: String
    let releaseDate: String
        
    init(artistName: String, artworkUrl100: String, collectionId: Int, collectionName: String, country: String, primaryGenreName: String, releaseDate: String) {
        self.artistName = artistName
        self.artworkUrl100 = artworkUrl100
        self.collectionId = collectionId
        self.collectionName = collectionName
        self.country = country
        self.primaryGenreName = primaryGenreName
        self.releaseDate = releaseDate
        
        DispatchQueue.main.async {
            SearchAlbumsService.shared.getSongs(collectionId: collectionId) { songsList in
                self.songs = songsList
            }
        }
    }
}

extension Album: Identifiable {
    
    var id: Int { collectionId }
}
