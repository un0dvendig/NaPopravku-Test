//
//  RepositoryListViewController.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 17.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class RepositoryListViewController: UIViewController {

    // MARK: - Properties
    
    var coordinator: RepostoriesCoordinator?
    
    // MARK: - Private properties
    
    private var viewReference: RepositoryListView?
    private var viewModel: RepositoryListViewModel?
    
    // MARK: - View life cycle
    
    override func loadView() {
        super.loadView()
        
        let view = RepositoryListView()
        self.viewReference = view
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// Hide the navigation bar for this view controller.
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /// Show the navigation bar for other view controllers.
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Private methods
    
    private func setupViewModel() {
        let viewModel = RepositoryListViewModel(coordinatorReference: coordinator)
        self.viewModel = viewModel
    }
    
    private func setupView() {
        guard let viewModel = viewModel else {
            return
        }
        viewReference?.configure(with: viewModel)
        
        // TODO: Handle errors
        RepositoryWarehouse.shared.fetchMoreRepositories { (result) in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self.viewReference?.repositoryListTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
