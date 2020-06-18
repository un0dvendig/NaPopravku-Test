//
//  UITableViewCell + ReuseIdentifier.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 17.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    /// Computed class property that helps to register/use cell.
    class var reuseIdentifier: String {
        return String(describing: self)
    }
}
