//
//  Owner.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 17.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

struct Owner {
    
    // MARK: - Properties
    
    let login: String
    var avatarURL: String?
    
}

// MARK: - Codable

extension Owner: Codable {
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
    
}
