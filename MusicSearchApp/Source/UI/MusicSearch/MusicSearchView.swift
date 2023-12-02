//
//  MusicSearchViewController.swift
//  MusicSearchApp
//
//  Created by Filipp Kosenko on 29.10.2023.
//

import UIKit

class MusicSearchView: BaseView<MusicSearchViewModel, MusicSearchViewModelOutputEvents> {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        setupVC()
    }
    
    // MARK: IBActions
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        viewModel.searchText = sender.text
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        viewModel.performSearch()
    }
}

// MARK: - Private

private extension MusicSearchView {
    
    func setupVC() {
        tableView.dataSource = self
        tableView.delegate = self
        title = "MVVM Binding Demo"
        setupBindings()
    }
    
    func setupBindings() {
        viewModel.results.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel.isButtonEnabled.bind { [weak self] isEnabled in
            self?.btnSearch.isEnabled = isEnabled
        }
        
        viewModel.isLoadingEnabled.bind { [weak self] isEnabled in
            if isEnabled {
                self?.activityIndicator.isHidden = false
                self?.activityIndicator.startAnimating()
            } else {
                self?.activityIndicator.isHidden = true
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension MusicSearchView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.results.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.getSearchResultVM(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = item.trackName
        content.secondaryText = item.collectionName
        cell.contentConfiguration = content
        
        return cell
    }
}

extension MusicSearchView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.viewModel.outputEvents?(.needShowDetails(model: self.viewModel.trackDetailsModel(index: indexPath.row) ))
    }
}
