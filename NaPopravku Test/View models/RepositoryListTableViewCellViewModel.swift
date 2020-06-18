//
//  RepositoryListTableViewCellViewModel.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 17.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation

struct RepositoryListTableViewCellViewModel {
    
    // MARK: - Private properties
    
    private let repository: Repository
    
    // MARK: - Initialization
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    // MARK: - Computed properties
    
    var repositoryName: String {
        return repository.name
    }
    
    var ownerLogin: String {
        return repository.owner.login
    }

    var ownerAvatarURL: URL? {
        guard let stringURL = repository.owner.avatarURL else {
            return nil
        }
        guard let url = URL(string: stringURL) else {
            return nil
        }
        return url
    }
    
}
