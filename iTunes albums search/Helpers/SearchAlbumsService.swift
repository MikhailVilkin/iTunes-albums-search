//
//  SearchAlbumsService.swift
//  iTunes albums search
//
//  Created by Михаил Вилкин on 07.09.2020.
//  Copyright © 2020 Михаил Вилкин. All rights reserved.
//

import Foundation

// This class is used to get albums information from iTunes
// It gets JSON data and parses it into swift object
class SearchAlbumsService {
    
    // singleton
    static let shared = SearchAlbumsService()
    private init() {}
    
    func getAlbums (searchRequest: String, complition: @escaping ([Album])->()) {
        
        // Creating URLSession object
        let search = searchRequest.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "\(Constants.BASE_URL)\(search)")
        let session = URLSession.shared
        
        // Get a data task from the URLSession
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                
                do {
                    // Get a JSON object
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    // Parsing the data into [Album]
                    if let albums = self.createAlbumsArray(json: json, searchRequest: searchRequest) {
                        complition(albums)
                    } else { return }
                    
                } catch {
                    
                    print(error.localizedDescription)
                }
                
            }
            
            if error != nil {
                
                print(error!.localizedDescription)
            }
            
        }
        
        // Kick off the task
        dataTask.resume()
    }
    
    private func createAlbumsArray(json: [String:Any], searchRequest: String) -> [Album]? {
        
        var albums = [Album]()
        
        if let albumResults = json["results"] as? NSArray {
            
            for album in albumResults {
                
                if let albumInfo = album as? [String: AnyObject] {
                    
                    guard let artistName = albumInfo["artistName"] as? String else { return nil }
                    guard let artworkUrl100 = albumInfo["artworkUrl100"] as? String else { return nil }
                    guard let collectionId = albumInfo["collectionId"] as? Int else { return nil }
                    guard let collectionName = albumInfo["collectionName"] as? String else { return nil }
                    guard let country = albumInfo["country"] as? String else { return nil }
                    guard let primaryGenreName = albumInfo["primaryGenreName"] as? String else { return nil }
                    guard let releaseDate = albumInfo["releaseDate"] as? String else { return nil }
                    
                    // Getting album's release year
                    let releaseDateFormatted = releaseDate.prefix(4)
                    
                    // Creating an album instance and appending it to an array
                    // Checking if the search is correct
                    if (artistName.contains(searchRequest) || collectionName.contains(searchRequest)) {
                        let albumInstance = Album(artistName: artistName, artworkUrl100: artworkUrl100, collectionId: collectionId, collectionName: collectionName, country: country, primaryGenreName: primaryGenreName, releaseDate: String(releaseDateFormatted))
                        albums.append(albumInstance)
                    }
                }
            }
        }
        
        return albums
    }
    
    func getSongs (collectionId: Int, complition: @escaping ([Song]) -> ()) {
        
        var songs = [Song]()
        let url = URL(string: "\(Constants.ALBUM_SONGS_URL)\(collectionId)")
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    if let songResults = json["results"] as? NSArray {
                        
                        for song in songResults {
                            
                            // 0 element is album info
                            if songResults.index(of: song) != 0 {
                                
                                if let songInfo = song as? [String: AnyObject] {
                                    
                                    guard let name = songInfo["trackName"] as? String else { return }
                                    guard let number = songInfo["trackNumber"] as? Int else { return }
                                    
                                    let newSong = Song(name: name, numberInAlbum: number)
                                    songs.append(newSong)
                                }                             
                            }
                        }
                        complition(songs)
                    }
                } catch {
                    
                    print(error.localizedDescription)
                }
            }
            
            if error != nil {
                
                print(error!.localizedDescription)
            }
        }
        
        dataTask.resume()
    }
}
