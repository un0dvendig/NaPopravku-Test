//
//  RepostoriesCoordinator.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 17.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class RepostoriesCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    
    func start() {
        let viewController = RepositoryListViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    /// Shows detail info about given Repository.
    func showDetailedInfoAbout(repository: Repository) {
        let viewController = RepositoryInfoViewController()
        viewController.coordinator = self
        viewController.repository = repository
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
