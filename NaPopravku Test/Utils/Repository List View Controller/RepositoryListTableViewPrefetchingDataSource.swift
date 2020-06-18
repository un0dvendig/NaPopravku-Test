//
//  RepositoryListTableViewPrefetchingDataSource.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 17.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class PostsListViewControllerPrefetchingDataSource: NSObject, UITableViewDataSourcePrefetching {
    
    // MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isFetchNeeded) {
            RepositoryWarehouse.shared.fetchMoreRepositories { (result) in
                switch result {
                case .success():
                    DispatchQueue.main.async {
                        tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    // MARK: - Private methods
    
    /// Check if new fetch needed.
    private func isFetchNeeded(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= RepositoryWarehouse.shared.totalNumberOfRepositories - 10
    }

}
