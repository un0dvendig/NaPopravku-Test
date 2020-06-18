//
//  CommitNode+Equatable.swift
//  NaPopravku Test Tests
//
//  Created by Eugene Ilyin on 18.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation
@testable import NaPopravku_Test

extension CommitNode: Equatable {
    
    public static func == (lhs: CommitNode, rhs: CommitNode) -> Bool {
        return lhs.author == rhs.author
            && lhs.message == rhs.message
    }
    
}
