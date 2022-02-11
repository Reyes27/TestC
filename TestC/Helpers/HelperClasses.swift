//
//  HelperClasses.swift
//  TestC
//
//  Created by móviles 2 on 10/02/22.
//

import UIKit

class DictionaryEncoder {
    private let jsonEncoder = JSONEncoder()
    
    /// Encodes given Encodable value into an array or dictionary
    func encode<T>(_ value: T) throws -> Any where T: Encodable {
        let jsonData = try jsonEncoder.encode(value)
        return try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
    }
    

    
}



