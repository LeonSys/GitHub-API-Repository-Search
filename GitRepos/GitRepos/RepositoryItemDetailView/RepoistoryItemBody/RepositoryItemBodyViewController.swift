//
//  RepoDetailsViewController.swift
//  GitRepos
//
//  Created by Leon Horvath on 10/02/2024.
//

import Foundation
import UIKit


public class RepositoryItemBodyViewController: UIViewController {
    
    let stackView = UIStackView()
    let repositoryItemDetails = RepositoryItemDetailsView()
    let actionButton = FancyButton(backgroundColor: .purple, title: "See on GitHub")
    var repositoryItem: RepositoryItem?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackgroundView()
        configureStackView()
        layoutSubviews()
    }
    init(repositoryItem: RepositoryItem?) {
        super.init(nibName: nil, bundle: nil)
        self.repositoryItem = repositoryItem
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        repositoryItemDetails.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(repositoryItemDetails)
        repositoryItemDetails.set(repositoryItem: repositoryItem)
        actionButton.addTarget(self, action: #selector(goToRepositoryLink), for: .touchUpInside)
    }
    
    @objc func goToRepositoryLink() {
        guard let repositoryItem = repositoryItem, let repoURL = repositoryItem.htmlURL else { return}
        if let url = URL(string: repoURL) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    private func layoutSubviews() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant:  10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
