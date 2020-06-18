//
//  Commit.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 18.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

struct Commit {
    
    // MARK: - Properties
    
    let sha: String
    let commit: CommitNode?
    let parents: [Commit]?
    
}

// MARK: - Codable

extension Commit: Codable {
    
    enum CodingKeys: String, CodingKey {
        case sha
        case commit
        case parents
    }
    
}
