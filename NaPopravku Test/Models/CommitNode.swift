//
//  CommitNode.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 18.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

struct CommitNode {
    
    // MARK: - Properties
    
    let author: CommitNodeAuthor
    let message: String
    
}

// MARK: - Codable

extension CommitNode: Codable {
    
    enum CodingKeys: String, CodingKey {
        case author
        case message
    }
    
}
