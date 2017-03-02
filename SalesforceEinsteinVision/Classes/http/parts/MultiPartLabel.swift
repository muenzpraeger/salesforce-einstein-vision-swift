//
//  MultiPartLabel.swift
//  Pods
//
//  Created by René Winkelmeyer on 02/28/2017.
//
//

import Alamofire
import Foundation

public struct MultiPartLabel : MultiPart {
    
    private let MAX_NAME = 180
    
    private var _name:String?
    
    public init() {}
    
    public mutating func build(name: String) throws {
        
        if name.isEmpty {
            throw ModelError.noFieldValue(field: "name")
        }
        if (name.characters.count>MAX_NAME) {
            throw ModelError.stringTooLong(field: "name", maxValue: MAX_NAME, currentValue: name.characters.count)
        }
        
        _name = name

    }
    
    public func form(multipart: MultipartFormData) {
        
        let data = _name?.data(using: String.Encoding.utf8)
        multipart.append(data!, withName: "name")
        
    }
    
}
