//
//  RepoItemInfoView.swift
//  GitRepos
//
//  Created by Leon Horvath on 10/02/2024.
//

import UIKit

class RepositoryItemDetailsView: UIView {
    
    let starIcon = UIImageView()
    let forkIcon = UIImageView()
    let lastUpdatedIcon = UIImageView()
    let creationDateIcon = UIImageView()
    
    let starGazersLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let forksNumberLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lastUpdateDateLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let creationDateLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
        setIcons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(starIcon)
        addSubview(starGazersLabel)
        addSubview(forksNumberLabel)
        addSubview(forkIcon)
        addSubview(lastUpdateDateLabel)
        addSubview(lastUpdatedIcon)
        addSubview(creationDateIcon)
        addSubview(creationDateLabel)
        
        forkIcon.translatesAutoresizingMaskIntoConstraints = false
        starIcon.translatesAutoresizingMaskIntoConstraints = false
        creationDateIcon.translatesAutoresizingMaskIntoConstraints = false
        lastUpdatedIcon.translatesAutoresizingMaskIntoConstraints = false
        
        lastUpdatedIcon.contentMode = .scaleToFill
        lastUpdatedIcon.tintColor = .orange

        creationDateIcon.contentMode = .scaleToFill
        creationDateIcon.tintColor = .systemGreen
        
        starIcon.contentMode = .scaleToFill
        starIcon.tintColor = .orange
        
        forkIcon.tintColor = .black
        forkIcon.contentMode = .scaleToFill
        
        NSLayoutConstraint.activate([
            starGazersLabel.topAnchor.constraint(equalTo: self.topAnchor),
            starGazersLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            starGazersLabel.heightAnchor.constraint(equalToConstant: 18),
            
            starIcon.centerYAnchor.constraint(equalTo: starGazersLabel.centerYAnchor),
            starIcon.leadingAnchor.constraint(equalTo: starGazersLabel.trailingAnchor, constant: 4),
            starIcon.heightAnchor.constraint(equalToConstant: 20),
            starIcon.widthAnchor.constraint(equalToConstant: 20),
            
            forksNumberLabel.topAnchor.constraint(equalTo: starIcon.bottomAnchor, constant: 4),
            forksNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            forksNumberLabel.heightAnchor.constraint(equalToConstant: 18),
            
            forkIcon.centerYAnchor.constraint(equalTo: forksNumberLabel.centerYAnchor),
            forkIcon.leadingAnchor.constraint(equalTo: forksNumberLabel.trailingAnchor, constant: 4),
            forkIcon.heightAnchor.constraint(equalToConstant: 18),
            forkIcon.widthAnchor.constraint(equalToConstant: 18),
            
            lastUpdateDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            lastUpdateDateLabel.topAnchor.constraint(equalTo: self.topAnchor),
            lastUpdateDateLabel.heightAnchor.constraint(equalToConstant: 18),
            
            lastUpdatedIcon.trailingAnchor.constraint(equalTo: lastUpdateDateLabel.leadingAnchor, constant: -5),
            lastUpdatedIcon.centerYAnchor.constraint(equalTo: lastUpdateDateLabel.centerYAnchor),
            lastUpdatedIcon.heightAnchor.constraint(equalToConstant: 20),
            lastUpdatedIcon.widthAnchor.constraint(equalToConstant: 20),
            
            creationDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            creationDateLabel.topAnchor.constraint(equalTo: lastUpdateDateLabel.bottomAnchor, constant: 4),
            creationDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            creationDateLabel.heightAnchor.constraint(equalToConstant: 18),
            
            creationDateIcon.trailingAnchor.constraint(equalTo: creationDateLabel.leadingAnchor, constant: -5),
            creationDateIcon.centerYAnchor.constraint(equalTo: creationDateLabel.centerYAnchor),
            creationDateIcon.heightAnchor.constraint(equalToConstant: 20),
            creationDateIcon.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func set(repositoryItem: RepositoryItem?) {
        guard let repositoryItem,
              let forksNumber = repositoryItem.forks,
              let starGazers = repositoryItem.stargazersCount,
              let createDate = repositoryItem.createdAt,
              let lastUpdateDate = repositoryItem.updatedAt else { return }
        
        self.forksNumberLabel.text = String(forksNumber)
        self.starGazersLabel.text = String(starGazers)
        self.creationDateLabel.text = createDate.toDisplayFormattedDate()
        self.lastUpdateDateLabel.text = lastUpdateDate.toDisplayFormattedDate()
    }
    
    private func setIcons() {
        self.forkIcon.image = UIImage(systemName: SFSymbols.fork)
        self.starIcon.image = UIImage(systemName: SFSymbols.star)
        self.creationDateIcon.image = UIImage(systemName: SFSymbols.created)
        self.lastUpdatedIcon.image = UIImage(systemName: SFSymbols.lastUpdated)

    }
}
