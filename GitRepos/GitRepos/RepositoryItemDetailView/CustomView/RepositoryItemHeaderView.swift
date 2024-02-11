//
//  CustomViews.swift
//  GitRepos
//
//  Created by Leon Horvath on 11/02/2024.
//

import Foundation
import UIKit

class RepositoryItemHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        clipsToBounds = true
        layer.cornerRadius = 5
    }
}
