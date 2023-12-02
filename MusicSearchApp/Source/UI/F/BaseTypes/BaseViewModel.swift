//
//  BaseViewModel.swift
//  MusicSearchApp
//
//  Created by Filipp Kosenko on 30.10.2023.
//

import Foundation

protocol ViewModelEvent { }

class BaseViewModel<Event: ViewModelEvent> {
    
    public var outputEvents: ((Event) -> ())?
    
    init() {
    }
}
