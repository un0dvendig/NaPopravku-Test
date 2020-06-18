//
//  RepositoryListView.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 17.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class RepositoryListView: UIView {

    // MARK: - Subviews
    
    lazy var repositoryListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RepositoryListTableViewCell.self, forCellReuseIdentifier: RepositoryListTableViewCell.reuseIdentifier)
        return tableView
    }()
    
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

    func configure(with viewModel: RepositoryListViewModel) {
        repositoryListTableView.delegate = viewModel.tableViewDelegate
        repositoryListTableView.dataSource = viewModel.tableViewDataSource
        repositoryListTableView.prefetchDataSource = viewModel.tableViewDataSourcePrefetching
        repositoryListTableView.reloadData()
    }
    
    // MARK: - Private methods
    
    private func addSubviews() {
        self.addSubview(repositoryListTableView)
    }
    
    private func setupSubviews() {
        repositoryListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryListTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            repositoryListTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            repositoryListTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            repositoryListTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
