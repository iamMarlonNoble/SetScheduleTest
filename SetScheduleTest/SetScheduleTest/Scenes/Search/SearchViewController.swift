//
//  SearchViewController.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/10/21.
//

import UIKit

class SearchViewController: UITableViewController {
  
  private let viewModel: SearchControllerViewModel

  private let searchController = UISearchController(searchResultsController: nil)
  
  private let cellId = "cellId"
  
  // TODO: - Call this from UserDefaults
  private var distance: Double = 10000
  
  init(_ viewModel: SearchControllerViewModel) {
    self.viewModel = viewModel
    
    super.init(style: .plain)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - Setup

private extension SearchViewController {
  func setup() {
    tableView.register(EventCell.self, forCellReuseIdentifier: cellId)
    
    setupSearchController()
    setupViewModel()
  }
  
  func setupViewModel() {
    
  }
  
  private func setupSearchController() {
    navigationItem.rightBarButtonItem = .init(
      image: UIImage(systemName: "gearshape.2"),
      style: .done,
      target: self,
      action: #selector(showSettingsVC)
    )
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.searchBar.delegate = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Here!"
  }
}

// MARK: - TableView

extension SearchViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.eventCellViewModels.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let eventCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? EventCell else {
      fatalError("Can't create cell")
    }
    
    eventCell.viewModel = viewModel.eventCellViewModels[indexPath.row]
    
    return eventCell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // Handle event URL
  }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
  }
}

// MARK: - Handlers

private extension SearchViewController {
  @objc func showSettingsVC() {
    
  }
}
