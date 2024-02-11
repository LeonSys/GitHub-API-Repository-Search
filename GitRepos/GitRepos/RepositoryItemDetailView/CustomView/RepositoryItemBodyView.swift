//
//  RepositorItemDetailView.swift
//  GitRepos
//
//  Created by Leon Horvath on 11/02/2024.
//

import UIKit

class RepositoryItemBodyView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 5
    }
}
