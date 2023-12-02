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
    
    var result: Binder<TrackDetailsModel>? = nil
    let error: Binder<String?> = Binder(nil)
    
    override init() {
        super.init()
    }
    
    func image(with url: URL?) {
        guard let gUrl = url else { return }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: gUrl)
                let image = UIImage(data: data)
                self.result?.value.artworkImage = image
                
            } catch {
                self.error.value = "*** ERROR ***"
            }
        }
    }
}
