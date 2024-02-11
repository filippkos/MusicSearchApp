//
//  Coordinator.swift
//  MusicSearchApp
//
//  Created by Filipp Kosenko on 29.10.2023.
//

import UIKit

public protocol Coordinator: AnyObject {
    
    var navigationViewController: UINavigationController { get set }
    
    func presentAlert(alertModel: AlertModel, controller: UIViewController?)
}

class AppCoordinator: Coordinator {
    
    // MARK: -
    // MARK: Variables
    
    var navigationViewController: UINavigationController
    
    // MARK: -
    // MARK: Init
    
    init(navigationController: UINavigationController) {
        self.navigationViewController = navigationController
        self.navigationViewController.navigationBar.isHidden = false
        self.prepareMusicSearchViewController()
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareMusicSearchViewController() {
        let controller = MusicSearchView(viewModel: MusicSearchViewModel())
        controller.viewModel.outputEvents = { [weak self] event in
            self?.handle(event: event, controller: controller)
            
        }
        self.navigationViewController.setViewControllers([controller], animated: true)
    }
    
    private func handle(event: MusicSearchViewModelOutputEvents, controller: UIViewController) {
        switch event {
        case let .needShowAlert(alertModel):
            self.presentAlert(alertModel: alertModel, controller: controller)
        case let .needShowDetails(model):
            self.pushTrackDetailsViewController(model: model)
        }
    }
    
    private func pushTrackDetailsViewController(model: TrackDetailsModel) {
        let viewModel = TrackDetailsViewModel(result: model)
        let controller = TrackDetailView(viewModel: viewModel)
        controller.viewModel.outputEvents = { [weak self] event in
            self?.handle(event: event, controller: controller)
        }
        self.navigationViewController.pushViewController(controller, animated: true)
    }
    
    private func handle(event: TrackDetailsViewOutputEvents, controller: UIViewController) {
        switch event {
        case .needShowAlert(let alertModel):
            self.presentAlert(alertModel: alertModel, controller: controller)
        }
    }
}

