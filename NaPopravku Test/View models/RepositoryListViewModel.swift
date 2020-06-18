//
//  RepositoryListViewModel.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 17.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

struct RepositoryListViewModel {
    
    // MARK: - Private properties
    
    private let dataSource: UITableViewDataSource
    private let dataSourcePrefetching: UITableViewDataSourcePrefetching
    private let delegate: UITableViewDelegate
    
    // MARK: - Initialization
    
    init(coordinatorReference: RepostoriesCoordinator? = nil, alertHandlerReference: AlertHandler? = nil) {
        let dataSource = RepositoryListTableViewDataSource()
        dataSource.alertHandlerReference = alertHandlerReference
        self.dataSource = dataSource
        self.dataSourcePrefetching = PostsListViewControllerPrefetchingDataSource()
        
        let delegate = RepositoryListTableViewDelegate()
        delegate.coordinatorReference = coordinatorReference
        self.delegate = delegate
    }
    
    // MARK: - Computed properties
    
    var tableViewDataSource: UITableViewDataSource {
        get {
            return self.dataSource
        }
    }
    
    var tableViewDelegate: UITableViewDelegate {
        get {
            return self.delegate
        }
    }
    
    var tableViewDataSourcePrefetching: UITableViewDataSourcePrefetching {
        get {
            return self.dataSourcePrefetching
        }
    }
    
}
