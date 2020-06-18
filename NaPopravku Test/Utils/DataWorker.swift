//
//  DataWorker.swift
//  NaPopravku Test
//
//  Created by Eugene Ilyin on 17.06.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import UIKit

/// A singleton object that is responsible for data conversion.
class DataWorker {
    
    // MARK: - Properties
    
    static let shared = DataWorker()
    
    // MARK: - Private properties
    
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    // MARK: - Initialization
    
    private init() {
        self.decoder = JSONDecoder()
        self.encoder = JSONEncoder()
    }
    
    // MARK: - Methods
    
    /// Convert given Data to UIImage. Returns optional UIImage.
    func convertDataToUIImage(_ data: Data) -> UIImage? {
        let image = UIImage(data: data)
        return image
    }
    
    /// Encode encodable model into Data.
    func encode<T: Encodable>(_ model: T) -> Data? {
        guard let data = try? encoder.encode(model) else {
            return nil
        }
        return data
    }

    /// Decode data into decodable model.
    func decode<T: Decodable>(_ data: Data) -> T? {
        guard let model = try? decoder.decode(T.self, from: data) else {
            return nil
        }
        return model
    }
    
    /// Convert given Data to String. Returns optional String.
//    func convertDataToString(_ data: Data) -> String? {
//        let string = String(data: data, encoding: .utf8)
//        return string
//    }
    
}
