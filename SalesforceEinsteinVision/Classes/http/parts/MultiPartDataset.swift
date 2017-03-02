//
//  MultiPartDataset.swift
//  Pods
//
//  Created by René Winkelmeyer on 02/28/2017.
//
//

import Alamofire
import Foundation

public struct MultiPartDataset : MultiPart {
    
    private let MAX_NAME = 180
    private let MAX_LABELS = 1000
    
    private var _name:String?
    private var _labels:[String]?
    
    public init() {}
    
    public mutating func build(name: String, labels: [String]) throws {
        
        if name.isEmpty {
            throw ModelError.noFieldValue(field: "name")
        }
        if (name.characters.count>MAX_NAME) {
            throw ModelError.stringTooLong(field: "name", maxValue: MAX_NAME, currentValue: name.characters.count)
        }
        if (labels.count==0) {
            throw ModelError.noValues(fields: "labels")
        }
        if (labels.count>1000) {
            throw ModelError.tooManyValues(field: "name", maxValue: MAX_LABELS, currentValue: labels.count)
        }
        
        _name = name
        _labels = labels
        
    }
    
    public func form(multipart: MultipartFormData) {
        
        let data = _name?.data(using: String.Encoding.utf8)
        multipart.append(data!, withName: "name")
        
        let join = _labels?.joined(separator: ",").data(using: String.Encoding.utf8)
        multipart.append(join!, withName: "labels")
        
    }
    
}
