//
//  SearchResponse.swift
//  MusicSearchApp
//
//  Created by Filipp Kosenko on 29.10.2023.
//

import Foundation


// MARK: - Main Object
struct SearchResponse: Codable {
    
    let resultCount: Int?
    let results: [SearchResult]?
}
    // MARK: - Result Item
    
struct SearchResult: Codable {
    
    var trackId: Int?
    var trackName: String?
    var collectionName: String?
    var trackPrice: Double?
    var currency: String?
    var artworkUrl60: URL?
}
    
#if DEBUG
// MARK: - Example Item

extension SearchResult {
    
    static var example: SearchResult {
        
        SearchResult(
            trackId: 157487434,
            trackName: "Home",
            collectionName: "Joe Satriani",
            trackPrice: 1.29,
            currency: "USD",
            artworkUrl60: URL(string: "https://is5-ssl.mzstatic.com/image/thumb/Music113/v4/c4/c1")
        )
    }
}

#endif
