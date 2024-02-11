//
//  ViewController.swift
//  GitRepos
//
//  Created by Leon Horvath on 09/02/2024.
//

import UIKit
import SwiftUI

struct Cells {
    static let repoCell = "repoCell"
}

class RepositoryListViewController: UIViewController {
    
    private let searchController = UISearchController()
    private let tableView = UITableView()
    private let viewModel = RepositoryListViewModel()
    
    var searchKeyWord: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: Cells.repoCell)
        setTableViewDelegates()
        tableView.pin(to: self.view)
        title = "Search for repos"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        tableView.dataSource = self
        fetchRepositories()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        self.removeSpinner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showSpinner(onView: self.view)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchRepositories() {
        viewModel.getReposCompletion(searchKeyWord: searchKeyWord) { success, message in
            guard success else {
                self.presentAlertOnMainThread(title: AlertMessages.errorDuringFetchTitle,
                                              message: message ?? "Unkown error" ,
                                              buttonTitle: AlertMessages.alertButtonTitle)
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func tappedCell() {
        guard let unwrappedNavigationController = self.navigationController else { return }
        unwrappedNavigationController.pushViewController(RepositoryItemViewController(), animated: true)
    }
    
    private func noResultsFoundAlert() {
        self.presentAlertOnMainThread(title: AlertMessages.noResultsOnSearchTitle,
                                      message: AlertMessages.noResultsOnSearchMessage + searchKeyWord,
                                      buttonTitle: AlertMessages.alertButtonTitle)
    }
}

extension RepositoryListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filterWord = searchController.searchBar.text else { return }
        viewModel.filterRepositories(keyWord: filterWord)
        self.tableView.reloadData()
    }
    
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        return isActive && !searchText.isEmpty
    }
}

extension RepositoryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inSearchMode = self.inSearchMode(searchController)
        return inSearchMode ? self.viewModel.filteredRepositories.count : self.viewModel.searchResultRepositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.repoCell, for: indexPath) as? RepositoryCell else {
            return UITableViewCell()
        }
        let inSearchMode = self.inSearchMode(searchController)
        let repoItem =  inSearchMode ? self.viewModel.filteredRepositories[indexPath.row] : self.viewModel.searchResultRepositories[indexPath.row]
        cell.contentConfiguration = UIHostingConfiguration(content: {
            RepositoryCellView(repoItem: repoItem)
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let unwrappedNavigationController = self.navigationController else { return }
        let repositoryItemViewController = RepositoryItemViewController()
        repositoryItemViewController.repoItem = viewModel.searchResultRepositories[indexPath.row]
        unwrappedNavigationController.pushViewController(repositoryItemViewController, animated: true)
    }
}
