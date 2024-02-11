//
//  TrackDetailsViewModel.swift
//  MusicSearchApp
//
//  Created by Filipp Kosenko on 30.10.2023.
//

import UIKit

enum TrackDetailsViewOutputEvents: ViewModelEvent {
    case needShowAlert(alertModel: AlertModel)
}

class TrackDetailsViewModel: BaseViewModel<TrackDetailsViewOutputEvents> {
    
    var result: Binder<TrackDetailsModel?> = Binder(nil)
    let error: Binder<String?> = Binder(nil)
    
    init(result: TrackDetailsModel) {
        self.result.value = result

        super.init()
        
        self.image(with: self.result.value?.artworkUrl60)
    }
    
    func image(with url: URL?) {
        guard let gUrl = url else { return }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: gUrl)
                let image = UIImage(data: data)
                self.result.value?.artworkImage = image
                
            } catch {
                self.error.value = "*** ERROR ***"
            }
        }
    }
}
