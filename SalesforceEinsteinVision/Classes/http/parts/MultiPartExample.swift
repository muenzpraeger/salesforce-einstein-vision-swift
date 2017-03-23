//
//  MultiPartExample.swift
//  Pods
//
//  Created by René Winkelmeyer on 02/28/2017.
//
//

import Alamofire
import Foundation

public struct MultiPartExample : MultiPart {
    
    private let MAX_NAME = 180
    
    private var _name:String?
    private var _labelId:Int?
    private var _file:URL?
    
    public init() {}
    
    public mutating func build(name: String, labelId: Int, file: URL) throws {
        
        if name.isEmpty {
            throw ModelError.noFieldValue(field: "name")
        }
        if (name.characters.count>MAX_NAME) {
            throw ModelError.stringTooLong(field: "name", maxValue: MAX_NAME, currentValue: name.characters.count)
        }
        if (labelId<0) {
            throw ModelError.intTooSmall(field: "labelId", minValue: 0, currentValue: labelId)
        }
        if file.absoluteString.isEmpty {
            throw ModelError.noFieldValue(field: "file")
        }
        
        _name = name
        _labelId = labelId
        _file = file
        
    }
    
    public func form(multipart: MultipartFormData) {
        
        let nameData = _name?.data(using: String.Encoding.utf8)
        multipart.append(nameData!, withName: "name")
        
        let labelIdData = String(describing: _labelId).data(using: String.Encoding.utf8)
        multipart.append(labelIdData!, withName: "labelId")
        
        multipart.append(_file!, withName: "data")
        
    }
    
}
