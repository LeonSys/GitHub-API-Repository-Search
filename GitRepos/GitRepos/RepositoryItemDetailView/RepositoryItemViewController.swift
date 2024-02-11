//
//  RepoItemViewController.swift
//  GitRepos
//
//  Created by Leon Horvath on 10/02/2024.
//

import UIKit

class RepositoryItemViewController: UIViewController {
    
    let headerView = RepositoryItemHeaderView()
    let bodyView = RepositoryItemBodyView()
    var repoItem: RepositoryItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutUI()
        add(childVC: RepositoryItemHeaderViewController(repoItem: repoItem), to: headerView)
        add(childVC: RepositoryItemBodyViewController(repositoryItem: repoItem) , to: bodyView)
    }
    
    private func layoutUI() {
        view.addSubview(headerView)
        view.addSubview(bodyView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -40),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 230),
            
            bodyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            bodyView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            bodyView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}
