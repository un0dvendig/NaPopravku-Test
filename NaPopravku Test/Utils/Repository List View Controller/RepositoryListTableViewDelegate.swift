//
//  RepositoryListTableViewDelegate.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 17.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class RepositoryListTableViewDelegate: NSObject, UITableViewDelegate {
    
    // MARK: - Properties
    
    weak var coordinatorReference: RepostoriesCoordinator?
    
    // MARK: - UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let repository = RepositoryWarehouse.shared.getRepository(at: indexPath.row) else {
            return
        }
        coordinatorReference?.showDetailedInfoAbout(repository: repository)
    }
    
}
