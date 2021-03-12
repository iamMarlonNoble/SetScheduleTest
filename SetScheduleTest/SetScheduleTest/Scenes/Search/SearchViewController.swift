//
//  SearchViewController.swift
//  SetScheduleTest
//
//  Created by Marlon on 3/10/21.
//

import SVProgressHUD

class SearchViewController: UITableViewController {
  
  private let viewModel: SearchControllerViewModel

  private let searchController = UISearchController(searchResultsController: nil)
  
  private let cellId = "cellId"
  
  init(_ viewModel: SearchControllerViewModel) {
    self.viewModel = viewModel
    
    super.init(style: .plain)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    title = viewModel.title
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
    viewModel.didUpdateEvents = { [weak self] in
      self?.tableView.reloadData()
    }
    
    viewModel.isLoadingHandler = { isLoading in
      if isLoading {
        SVProgressHUD.show()
      } else {
        SVProgressHUD.dismiss()
      }
    }
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
    if let url = viewModel.eventCellViewModels[indexPath.row].url {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
      let detailsVCViewModel = viewModel.detailsVCViewModels[indexPath.row]
      let detailsViewController = DetailsViewController(viewModel: detailsVCViewModel)
      navigationController?.pushViewController(detailsViewController, animated: true)
      
    }
  }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.searchEvent(with: searchBar.text ?? "")
  }
}

// MARK: - Handlers

private extension SearchViewController {
  @objc func showSettingsVC() {
    let settingsVC = SettingsViewController()
    navigationController?.pushViewController(settingsVC, animated: true)
  }
}
