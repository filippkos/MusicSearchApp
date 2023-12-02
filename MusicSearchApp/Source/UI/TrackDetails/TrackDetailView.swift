//
//  TrackDetailView.swift
//  MusicSearchApp
//
//  Created by Filipp Kosenko on 30.10.2023.
//

import UIKit

class TrackDetailView: BaseView<TrackDetailsViewModel, TrackDetailsViewOutputEvents> {
    
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var collectionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBindings()
        self.viewModel.image(with: self.viewModel.result?.value.artworkUrl60)
    }
    
    func configure(model: TrackDetailsModel) {
        
        self.cover.image = model.artworkImage
        self.songNameLabel.text = model.trackName
        self.artistLabel.text = model.collectionName
        self.collectionLabel.text = model.collectionName
    }
}

// MARK: - Private

private extension TrackDetailView {
    
    func setupBindings() {
        self.viewModel.result?.bind { [weak self] _ in
            guard let model = self?.viewModel.result?.value else { return }
            self?.configure(model: model)
        }
    }
}

