//
//  RepositoryListViewModel.swift
//  GitRepos
//
//  Created by Leon Horvath on 11/02/2024.
//

import Foundation

public class RepositoryListViewModel {
    
    var searchResultRepositories: [RepositoryItem] = []
    var filteredRepositories: [RepositoryItem] = []
    
    
    func getRepos(searchKeyWord: String) {
        NetworkManager.shared.getRepositories(searchingKeyWord: searchKeyWord){ result in
            switch result {
            case.success(let repositories):
                guard let repos = repositories.items, !repos.isEmpty else {
                    return
                }
                self.searchResultRepositories = repositories.items!
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func getReposCompletion(searchKeyWord: String, _ completion: @escaping (_ success: Bool, _ message: String?) -> Void) {
        NetworkManager.shared.getRepositories(searchingKeyWord: searchKeyWord){ result in
            switch result {
            case.success(let repositories):
                guard let repos = repositories.items, !repos.isEmpty else {
                    completion(false, NetworkError.invalidResponse.rawValue)
                    return
                }
                self.searchResultRepositories = repositories.items!
                completion(true, nil)
                return
            case.failure(let error):
                completion(false, error.localizedDescription)
                return
            }
        }
    }
    
    func filterRepositories(keyWord: String) {
        filteredRepositories = searchResultRepositories.filter{ $0.fullName.lowercased().contains(keyWord.lowercased()) }
    }
}
