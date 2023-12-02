//
//  TrackDetailsModel.swift
//  MusicSearchApp
//
//  Created by Filipp Kosenko on 01.11.2023.
//

import Foundation
import UIKit

class TrackDetailsModel {
    
    private var searchResult: SearchResult
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
    }
    
    var trackId: Int {
        searchResult.trackId ?? 0
    }
    
    var trackName: String {
        searchResult.trackName ?? "---"
    }
    
    var collectionName: String {
        searchResult.collectionName ?? "---"
    }
    
    var trackPrice: Double {
        searchResult.trackPrice ?? 0
    }
    
    var currency: String {
        searchResult.currency ?? "---"
    }
    
    var artworkUrl60: URL {
        searchResult.artworkUrl60 ?? URL(fileURLWithPath: "")
    }
    
    var artworkImage: UIImage? = UIImage(named: "music.note")
}
