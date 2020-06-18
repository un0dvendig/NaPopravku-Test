//
//  Commit+Equatable.swift
//  NaPopravku Test Tests
//
//  Created by Eugene Ilyin on 18.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation
@testable import NaPopravku_Test

extension Commit: Equatable {
    
    public static func == (lhs: Commit, rhs: Commit) -> Bool {
        return lhs.sha == rhs.sha
    }
    
}
