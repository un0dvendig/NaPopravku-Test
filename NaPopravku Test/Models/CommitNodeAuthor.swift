//
//  CommitNodeAuthor.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 18.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

struct CommitNodeAuthor {
    
    // MARK: - Properties
    
    let name: String
    let date: String
    
}

// MARK: - Codable

extension CommitNodeAuthor: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case date
    }
    
}
