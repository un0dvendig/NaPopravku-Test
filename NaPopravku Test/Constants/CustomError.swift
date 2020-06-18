//
//  CustomError.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 17.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation

/// An enumeration for the custom errors.
public enum CustomError: Error {
    case cannotBuildURL
    case cannotCreateUIImage
    case requestLimit
    case errorWithText(String)
    case unknown
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .cannotBuildURL:
            return ErrorText.cannotBuildURL.rawValue
        case .cannotCreateUIImage:
            return ErrorText.cannotCreateUIImage.rawValue
        case .requestLimit:
            return ErrorText.requestLimit.rawValue
        case .unknown:
            return ErrorText.unknown.rawValue
        case .errorWithText(let text):
            return text
        }
    }
}

public enum ErrorText: String {
    case cannotBuildURL = "Cannot build an URL"
    case cannotCreateUIImage = "Cannot create an UIImage"
    case requestLimit = "Request limit exceeded"
    case unknown = "Unknown error"
}
