//
//  MusicSearchViewModel.swift
//  MusicSearchApp
//
//  Created by Filipp Kosenko on 29.10.2023.
//

import Foundation

enum MusicSearchViewModelOutputEvents: ViewModelEvent {
    
    case needShowAlert(alertModel: AlertModel)
    case needShowDetails(model: TrackDetailsModel)
}

class MusicSearchViewModel: BaseViewModel<MusicSearchViewModelOutputEvents> {
    
    let results: Binder<[SearchResult]> = Binder([])
    let error: Binder<String?> = Binder(nil)
    let isButtonEnabled: Binder<Bool> = Binder(false)
    let isLoadingEnabled: Binder<Bool> = Binder(false)
    
    var searchText: String? = nil {
        didSet { isButtonEnabled.value = getEnabledFlowStatus() }
    }
    
    func performSearch() {
        guard let gSearchText = searchText else { return }
        
        let search = gSearchText.addingPercentEncoding(
            withAllowedCharacters: .urlHostAllowed
        ) ?? ""
        
        guard let gUrl = URL(
            string: "https://itunes.apple.com/search?term=\(search)"
        ) else { return }
        
        isLoadingEnabled.value = true
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: gUrl)
                let response = try JSONDecoder()
                    .decode(SearchResponse.self, from: data)
                isLoadingEnabled.value = false
                results.value = response.results ?? []
            } catch {
                isLoadingEnabled.value = false
                self.error.value = "*** ERROR ***"
            }
        }
    }
    
    func getSearchResultVM(at index: Int) -> SearchResultViewModel {
        
        let item = results.value[index]
        return SearchResultViewModel(searchResult: item)
    }
    
    func trackDetailsModel(index: Int) -> TrackDetailsModel {
        
        let searchResult = self.results.value[index]
        let trackModel = TrackDetailsModel(searchResult: searchResult)
        
        return trackModel
    }
}

private extension MusicSearchViewModel {
    
    func getEnabledFlowStatus() -> Bool {
        guard let gSearchText = searchText else { return false }
        return gSearchText.count >= 3
    }
}
