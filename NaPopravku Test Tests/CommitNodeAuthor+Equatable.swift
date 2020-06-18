//
//  CommitNodeAuthor+Equatable.swift
//  NaPopravku Test Tests
//
//  Created by Eugene Ilyin on 18.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation
@testable import NaPopravku_Test

extension CommitNodeAuthor: Equatable {
    
    public static func == (lhs: CommitNodeAuthor, rhs: CommitNodeAuthor) -> Bool {
        return lhs.name == rhs.name
            && lhs.date == rhs.date
    }
    
}
