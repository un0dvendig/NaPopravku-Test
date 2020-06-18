//
//  Repository.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 17.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

class Repository: Codable {
    
    // MARK: - Properties
    
    let id: Int
    var name: String
    let owner: Owner
    let commitsURL: String
    var commits: [Commit]?
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case commitsURL = "commits_url"
    }
    
    // MARK: - Initialization
    
    init(id: Int, name: String, owner: Owner, commitsURL: String, commits: [Commit]?) {
        self.id = id
        self.name = name
        self.owner = owner
        self.commitsURL = commitsURL
        self.commits = commits
    }
    
    // MARK: - Decodable
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.owner = try container.decode(Owner.self, forKey: .owner)
        self.commitsURL = try container.decode(String.self, forKey: .commitsURL)
    }
    
    //MARK: - Encodable
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.owner, forKey: .owner)
        try container.encode(self.commitsURL, forKey: .commitsURL)
    }
    
}

// MARK: - Equatable

extension Repository: Equatable {
    
    static func == (lhs: Repository, rhs: Repository) -> Bool {
        return lhs.id == rhs.id
    }
    
}
