//
//  RepositoryInfoViewModel.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 18.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation

struct RepositoryInfoViewModel {
    
    // MARK: - Private properties
    private let dateInputFormatter: ISO8601DateFormatter
    private let dateOutputFormatter: DateFormatter
    private var repository: Repository
    
    // MARK: - Initialization
    
    init(repository: Repository) {
        let dateInputFormatter = ISO8601DateFormatter()
        
        let dateOutputFormatter = DateFormatter()
        dateOutputFormatter.dateFormat = "dd.mm.yyyy"
        
        self.dateInputFormatter = dateInputFormatter
        self.dateOutputFormatter = dateOutputFormatter
        self.repository = repository
    }
    
    // MARK: - Computed private properties
    
    private var lastCommit: Commit? {
        return repository.commits?.last
    }
    
    // MARK: - Computed properties
    
    var repositoryReference: Repository {
        return repository
    }
    
    var needsMoreInfo: Bool {
        return lastCommit == nil
    }
    
    var repositoryName: String {
        return repository.name
    }
    
    var repositoryOwnerLogin: String {
        return repository.owner.login
    }

    var repositoryOwnerAvatarURL: URL? {
        guard let stringURL = repository.owner.avatarURL else {
            return nil
        }
        guard let url = URL(string: stringURL) else {
            return nil
        }
        return url
    }
    
    var lastCommitMessage: String {
        guard let message = lastCommit?.commit?.message else {
            fatalError("Check 'needsMoreInfo' before accessing this property.")
        }
        return message
    }
    
    var lastCommitAuthorName: String {
        guard let authorName = lastCommit?.commit?.author.name else {
            fatalError("Check 'needsMoreInfo' before accessing this property.")
        }
        return authorName
    }
    
    // TODO: Formate date to be dd.mm.yyyy
    var lastCommitDate: String {
        guard let dateString = lastCommit?.commit?.author.date else {
            fatalError("Check 'needsMoreInfo' before accessing this property.")
        }
        guard let date = dateInputFormatter.date(from: dateString) else {
            fatalError("Cannot format given date: \(dateString)")
        }
        return dateOutputFormatter.string(from: date)
    }
    
    var shaParents: String {
        guard let lastCommit = lastCommit else {
            fatalError("Check 'needsMoreInfo' before accessing this property.")
        }
        if let parents = lastCommit.parents {
            if parents.count != 0 {
                var shaList = String()
                for parent in parents {
                    shaList.append("\(parent.sha)\n")
                }
                shaList.removeLast()
                return shaList
            }
        }
        return "This is the first commit that has no parents"
    }
    
}