//
//  DummyViewController.swift
//  GitRepos
//
//  Created by Leon Horvath on 10/02/2024.
//

import UIKit

class SearchViewController: UIViewController {

    private let logoImageView = UIImageView()
    private let textField = FancyTextField()
    private let searchButton = FancyButton(backgroundColor: .systemGreen, title: "Search")
    
    override func viewDidLoad() {
      super.viewDidLoad()
        view.backgroundColor = .systemBackground
        textField.delegate = self
        configureView()
    }
    
    private func configureView() {
        view.addSubview(logoImageView)
        view.addSubview(textField)
        view.addSubview(searchButton)
        createDismissKeyBoardTapGesture()
        searchButton.addTarget(self, action: #selector(pushToRepoListViewController), for: .touchUpInside)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "github-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 300),
            logoImageView.widthAnchor.constraint(equalToConstant: 450),
            
            textField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textField.widthAnchor.constraint(equalToConstant: 400),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            searchButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func pushToRepoListViewController() {
        guard textField.text != "", let searchKey = textField.text else {
            showAlert()
            return
        }
        let repoListVC = RepositoryListViewController()
        repoListVC.searchKeyWord = searchKey
        navigationController?.pushViewController(repoListVC, animated: true)
    }
    
    private func showAlert() {
        self.presentAlertOnMainThread(title: AlertMessages.emptySearchFieldTitle,
                                      message: AlertMessages.emptySearchFieldMessage,
                                      buttonTitle: AlertMessages.alertButtonTitle)
    }
    
    private func createDismissKeyBoardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushToRepoListViewController()
        return true
    }
}
