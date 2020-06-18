//
//  RepositoryListTableViewDataSource.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 17.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class RepositoryListTableViewDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    
    weak var alertHandlerReference: AlertHandler?
    
    // MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        RepositoryWarehouse.shared.totalNumberOfRepositories
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryListTableViewCell.reuseIdentifier) as? RepositoryListTableViewCell else {
            fatalError("Dequeued cell should be of type RepositoryListTableViewCell")
        }
        cell.alertHandlerReference = alertHandlerReference
        
        guard let repository = RepositoryWarehouse.shared.getRepository(at: indexPath.row) else {
            fatalError("Cannot find the Repository entity for the cell at \(indexPath)")
        }
        
        let viewModel = RepositoryListTableViewCellViewModel(repository: repository)
        cell.configure(with: viewModel)
        
        return cell
    }
    
    
    
    
}
