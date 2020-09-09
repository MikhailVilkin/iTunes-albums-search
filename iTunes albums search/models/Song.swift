//
//  Song.swift
//  iTunes albums search
//
//  Created by Михаил Вилкин on 07.09.2020.
//  Copyright © 2020 Михаил Вилкин. All rights reserved.
//

import Foundation

class Song {
    var name: String
    var numberInAlbum: Int
    
    init(name: String, numberInAlbum: Int) {
        self.numberInAlbum = numberInAlbum
        self.name = name
    }
}


extension Song: Identifiable {
    
    var id: Int { numberInAlbum }
}
