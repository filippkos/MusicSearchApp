//
//  SearchResultViewModel.swift
//  MusicSearchApp
//
//  Created by Filipp Kosenko on 29.10.2023.
//

import Foundation

class SearchResultViewModel {
    
    private var searchResult: SearchResult
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
    }
    
    var trackName: String {
        searchResult.trackName ?? "---"
    }
    
    var collectionName: String {
        searchResult.collectionName ?? "---"
    }
}
