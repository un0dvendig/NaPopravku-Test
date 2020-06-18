//
//  RepositoryInfoView.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 18.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class RepositoryInfoView: UIView {
    
    // MARK: - Subviews
    
    lazy var repositoryInfoRepositoryNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var repositoryInfoRepositoryAuthorAvatarImageView: AsyncImageView = {
        let imageView = AsyncImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var repositoryInfoRepositoryAuthorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var repositoryLastCommitInfoLoadingActivityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .gray
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    lazy var repositoryInfoLastCommitMessageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var repositoryInfoLastCommitAuthorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var repositoryInfoLastCommitDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var repositoryInfoLastCommitParentsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    // MARK: - Properties
    
    weak var alertHandlerReference: AlertHandler?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        addSubviews()
        setupSubviews()
    }
    
    @available(*, unavailable, message: "use init(frame:) instead")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods

    func configure(with viewModel: RepositoryInfoViewModel) {
        repositoryInfoRepositoryNameLabel.text = viewModel.repositoryName
        
        if let url = viewModel.repositoryOwnerAvatarURL {
            repositoryInfoRepositoryAuthorAvatarImageView.loadImageFrom(url: url) { (result) in
                switch result {
                case .success():
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.alertHandlerReference?.showAlertDialog(title: "Error while loading repository author avatar", message: error.localizedDescription)
                    }
                }
            }
        }
        
        if viewModel.needsMoreInfo {
            repositoryLastCommitInfoLoadingActivityIndicatorView.startAnimating()
            RepositoryWarehouse.shared.fetchMoreInfo(about: viewModel.repositoryReference) { (result) in
                switch result {
                case .success():
                    DispatchQueue.main.async {
                        self.configureLastCommit(with: viewModel)
                        self.repositoryLastCommitInfoLoadingActivityIndicatorView.stopAnimating()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        print(error)
                        self.repositoryLastCommitInfoLoadingActivityIndicatorView.stopAnimating()
                    }
                }
            }
        } else {
            configureLastCommit(with: viewModel)
        }
    }
    
    // MARK: - Private methods
    
    private func configureLastCommit(with viewModel: RepositoryInfoViewModel) {
        repositoryInfoLastCommitMessageLabel.text = viewModel.lastCommitMessage
        repositoryInfoLastCommitAuthorNameLabel.text = viewModel.lastCommitAuthorName
        repositoryInfoLastCommitDateLabel.text = viewModel.lastCommitDate
        repositoryInfoLastCommitParentsLabel.text = viewModel.lastCommitShaParents
    }
    
    private func addSubviews() {
        self.addSubview(repositoryInfoRepositoryNameLabel)
        self.addSubview(repositoryInfoRepositoryAuthorAvatarImageView)
        self.addSubview(repositoryInfoRepositoryAuthorNameLabel)
        
        self.addSubview(repositoryLastCommitInfoLoadingActivityIndicatorView)
        self.addSubview(repositoryInfoLastCommitMessageLabel)
        self.addSubview(repositoryInfoLastCommitAuthorNameLabel)
        self.addSubview(repositoryInfoLastCommitDateLabel)
        self.addSubview(repositoryInfoLastCommitParentsLabel)
        
    }
    
    private func setupSubviews() {
        setupRepositoryNameLabel()
        setupRepositoryAuthorAvatarImageView()
        setupRepositoryAuthorNameLabel()
        
        setupLastCommitInfoLoadingActivityIndicatorView()
        setupLastCommitMessageLabel()
        setupLastCommitAuthorNameLabel()
        setupLastCommitDateLabel()
        setupLastCommitParentsLabel()
    }
    
    private func setupRepositoryNameLabel() {
        repositoryInfoRepositoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryInfoRepositoryNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            repositoryInfoRepositoryNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            repositoryInfoRepositoryNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
        
        repositoryInfoRepositoryNameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func setupRepositoryAuthorAvatarImageView() {
        repositoryInfoRepositoryAuthorAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryInfoRepositoryAuthorAvatarImageView.topAnchor.constraint(equalTo: repositoryInfoRepositoryNameLabel.bottomAnchor, constant: 5),
            repositoryInfoRepositoryAuthorAvatarImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            repositoryInfoRepositoryAuthorAvatarImageView.widthAnchor.constraint(equalTo: repositoryInfoRepositoryAuthorAvatarImageView.heightAnchor, multiplier: 1),
            repositoryInfoRepositoryAuthorAvatarImageView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.6, constant: -10)
        ])
    }
    
    private func setupRepositoryAuthorNameLabel() {
        repositoryInfoRepositoryAuthorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryInfoRepositoryAuthorNameLabel.topAnchor.constraint(equalTo: repositoryInfoRepositoryAuthorAvatarImageView.bottomAnchor, constant: 5),
            repositoryInfoRepositoryAuthorNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            repositoryInfoRepositoryAuthorNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
        
        repositoryInfoRepositoryAuthorNameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func setupLastCommitInfoLoadingActivityIndicatorView() {
        repositoryLastCommitInfoLoadingActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryLastCommitInfoLoadingActivityIndicatorView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            repositoryLastCommitInfoLoadingActivityIndicatorView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setupLastCommitMessageLabel() {
        repositoryInfoLastCommitMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryInfoLastCommitMessageLabel.topAnchor.constraint(equalTo: repositoryInfoRepositoryAuthorNameLabel.bottomAnchor, constant: 5),
            repositoryInfoLastCommitMessageLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            repositoryInfoLastCommitMessageLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
        
        repositoryInfoLastCommitMessageLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func setupLastCommitAuthorNameLabel() {
        repositoryInfoLastCommitAuthorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryInfoLastCommitAuthorNameLabel.topAnchor.constraint(equalTo: repositoryInfoLastCommitMessageLabel.bottomAnchor, constant: 5),
            repositoryInfoLastCommitAuthorNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            repositoryInfoLastCommitAuthorNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
        
        repositoryInfoLastCommitAuthorNameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func setupLastCommitDateLabel() {
        repositoryInfoLastCommitDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryInfoLastCommitDateLabel.topAnchor.constraint(equalTo: repositoryInfoLastCommitAuthorNameLabel.bottomAnchor, constant: 5),
            repositoryInfoLastCommitDateLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            repositoryInfoLastCommitDateLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ])
        
        repositoryInfoLastCommitDateLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func setupLastCommitParentsLabel() {
        repositoryInfoLastCommitParentsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryInfoLastCommitParentsLabel.topAnchor.constraint(equalTo: repositoryInfoLastCommitDateLabel.bottomAnchor, constant: 5),
            repositoryInfoLastCommitParentsLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            repositoryInfoLastCommitParentsLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            repositoryInfoLastCommitParentsLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
        
        repositoryInfoLastCommitParentsLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
