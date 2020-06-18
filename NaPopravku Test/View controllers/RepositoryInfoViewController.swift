//
//  RepositoryInfoViewController.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 18.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

class RepositoryInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    var coordinator: RepostoriesCoordinator?
    var repository: Repository?
    
    // MARK: - Private properties
    
    private var alertHandler: AlertHandler?
    private var viewReference: RepositoryInfoView?
    private var viewModel: RepositoryInfoViewModel?
    
    // MARK: - View life cycle
    
    override func loadView() {
        super.loadView()
        
        self.alertHandler = AlertHandler(delegate: self)
        let view = RepositoryInfoView()
        view.alertHandlerReference = self.alertHandler
        self.viewReference = view
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupView()
    }
    
    // MARK: - Private methods
    
    private func setupViewModel() {
        guard let repository = repository else {
            fatalError("Repository info view controller should have repository at this point.")
        }
        let viewModel = RepositoryInfoViewModel(repository: repository)
        self.viewModel = viewModel
    }
    
    private func setupView() {
        guard let viewModel = viewModel else {
            return
        }
        viewReference?.configure(with: viewModel)
    }
    
}
