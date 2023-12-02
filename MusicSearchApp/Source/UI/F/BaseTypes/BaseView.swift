//
//  BaseView.swift
//  MusicSearchApp
//
//  Created by Filipp Kosenko on 30.10.2023.
//

import UIKit

class BaseView<ViewModel, ViewModelEventType>: UIViewController
where ViewModel: BaseViewModel<ViewModelEventType>, ViewModelEventType: ViewModelEvent {
    
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
