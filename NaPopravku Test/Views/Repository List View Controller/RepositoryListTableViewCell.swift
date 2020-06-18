//
//  RepositoryListTableViewCell.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 17.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class RepositoryListTableViewCell: UITableViewCell {

    // MARK: - Subviews
    
    lazy var repositoryOwnerAvatarImageView: AsyncImageView = {
        let imageView = AsyncImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var repositoryOwnerAvatarImageLoadingIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    lazy var repositoryOwnerLoginLabel: UILabel = {
        let label = UILabel()
        label.text = "login"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var repositoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Repository-Name"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    // MARK: - Properties
    
    weak var alertHandlerReference: AlertHandler?
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        addSubviews()
        setupSubviews()
    }
    
    @available(*, unavailable, message: "use init(style:reuseIdentifier:) instead")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(with viewModel: RepositoryListTableViewCellViewModel) {
        repositoryNameLabel.text = viewModel.repositoryName
        
        repositoryOwnerLoginLabel.text = viewModel.ownerLogin
        
        repositoryOwnerAvatarImageLoadingIndicatorView.startAnimating()
        if let avatarURL = viewModel.ownerAvatarURL {
            repositoryOwnerAvatarImageView.loadImageFrom(url: avatarURL) { (result) in
                switch result {
                case .success():
                    DispatchQueue.main.async {
                        self.repositoryOwnerAvatarImageView.layer.cornerRadius = self.repositoryOwnerAvatarImageView.frame.height / 2
                        self.repositoryOwnerAvatarImageLoadingIndicatorView.stopAnimating()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.repositoryOwnerAvatarImageLoadingIndicatorView.stopAnimating()
                        self.alertHandlerReference?.showAlertDialog(title: "Error while loading owner avatar image", message: error.localizedDescription)
                    }
                }
            }
        } else {
            repositoryOwnerAvatarImageLoadingIndicatorView.stopAnimating()
        }
    }
    
    // MARK: - Private methods
    
    private func addSubviews() {
        self.addSubview(repositoryOwnerAvatarImageView)
        repositoryOwnerAvatarImageView.addSubview(repositoryOwnerAvatarImageLoadingIndicatorView)
        
        self.addSubview(repositoryOwnerLoginLabel)
        self.addSubview(repositoryNameLabel)
    }
    
    private func setupSubviews() {
        setupOwnerAvatarImageView()
        setupOwnerAvatarImageLoadingIndicatorView()
        setupOwnerLoginLabel()
        setupNameLabel()
    }
    
    private func setupOwnerAvatarImageView() {
        repositoryOwnerAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryOwnerAvatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            repositoryOwnerAvatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            repositoryOwnerAvatarImageView.heightAnchor.constraint(equalTo: repositoryOwnerAvatarImageView.widthAnchor, multiplier: 1),
            repositoryOwnerAvatarImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
    
    private func setupOwnerAvatarImageLoadingIndicatorView() {
        repositoryOwnerAvatarImageLoadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryOwnerAvatarImageLoadingIndicatorView.centerXAnchor.constraint(equalTo: repositoryOwnerAvatarImageView.centerXAnchor),
            repositoryOwnerAvatarImageLoadingIndicatorView.centerYAnchor.constraint(equalTo: repositoryOwnerAvatarImageView.centerYAnchor)
        ])
    }
    
    private func setupNameLabel() {
        repositoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            repositoryNameLabel.leadingAnchor.constraint(equalTo: repositoryOwnerAvatarImageView.trailingAnchor, constant: 5),
            repositoryNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
        
        repositoryNameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func setupOwnerLoginLabel() {
        repositoryOwnerLoginLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryOwnerLoginLabel.topAnchor.constraint(equalTo: repositoryNameLabel.bottomAnchor, constant: 5),
            repositoryOwnerLoginLabel.leadingAnchor.constraint(equalTo: repositoryNameLabel.leadingAnchor),
            repositoryOwnerLoginLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            repositoryOwnerLoginLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
    
}
