//
//  RepoHeaderViewController.swift
//  GitRepos
//
//  Created by Leon Horvath on 10/02/2024.
//

import UIKit

class RepositoryItemHeaderViewController: UIViewController {
    
    let avatarImageView = UIImageView()
    let userNameIcon = UIImageView()
    let repositoryItem: RepositoryItem?
    
    let repoNameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userProfileLink: UITextView = {
        var label = UITextView()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.isEditable = false
        label.dataDetectorTypes = .link
        return label
    }()
    
    let userNameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .blue
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(repoItem: RepositoryItem?) {
        repositoryItem = repoItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = true
        layoutUI()
        fillElementsWithData()
    }
    
    private func configureUIElements() {
        avatarImageView.layer.cornerRadius = 10
        view.backgroundColor = .white
        avatarImageView.clipsToBounds = true
    }
    
    private func fillElementsWithData() {
        guard let repositoryItem, let owner = repositoryItem.owner, let avatarURL = owner.avatarURL else { return }
        
        let attributedString = NSMutableAttributedString(string: "Just click here to check profile")
        attributedString.setAttributes([.link: owner.htmlURL!], range: NSMakeRange(5, 10))
        userProfileLink.attributedText = attributedString
        
        repoNameLabel.text = repositoryItem.fullName
        userNameIcon.image = UIImage(systemName: SFSymbols.user)
        
        descriptionLabel.text = repositoryItem.description
        
        userNameLabel.text = owner.login
        
        avatarImageView.downloadImage(from: avatarURL)
    }
    
    private func layoutUI() {
        view.addSubview(avatarImageView)
        view.addSubview(userProfileLink)
        view.addSubview(repoNameLabel)
        view.addSubview(userNameIcon)
        view.addSubview(descriptionLabel)
        view.addSubview(userNameLabel)
        
        configureUIElements()

        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameIcon.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            repoNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            repoNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            repoNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            repoNameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            userProfileLink.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            userProfileLink.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            userProfileLink.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            userProfileLink.heightAnchor.constraint(equalToConstant: 20),
            
            userNameIcon.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            userNameIcon.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            userNameIcon.heightAnchor.constraint(equalToConstant: 20),
            userNameIcon.widthAnchor.constraint(equalToConstant: 20),
            
            userNameLabel.centerYAnchor.constraint(equalTo: userNameIcon.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: userNameIcon.trailingAnchor, constant: 5),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 60),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
    }
}
