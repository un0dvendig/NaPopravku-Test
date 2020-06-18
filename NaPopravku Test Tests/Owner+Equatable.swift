//
//  Owner+Equatable.swift
//  NaPopravku Test Tests
//
//  Created by Eugene Ilyin on 18.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation
@testable import NaPopravku_Test

extension Owner: Equatable {
    
    public static func == (lhs: Owner, rhs: Owner) -> Bool {
        return lhs.login == rhs.login
    }
    
}
