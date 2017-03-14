//
//  MultiPartDatasetZipFile.swift
//  EinsteinVisionFramer
//
//  Created by René Winkelmeyer on 14/03/2017.
//  Copyright © 2017 René Winkelmeyer. All rights reserved.
//

import Alamofire
import Foundation

public struct MultiPartDatasetZipFile : MultiPart {
    
    private var _data:String?
    
    public init() {}
    
    public mutating func build(fileName: String) throws {
        
        if fileName.isEmpty {
            throw ModelError.noFieldValue(field: "name")
        }
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: fileName) {
            throw ModelError.fileDoesNotExist(fileName: fileName)
        }
        if (!fileName.lowercased().hasSuffix("zip")) {
            throw ModelError.fileNoZipFile(fileName: fileName)
        }
        let attr = try fileManager.attributesOfItem(atPath: fileName)
        
        let fileSize = attr[FileAttributeKey.size] as! UInt64
        
        if (fileSize>50000000) {
            throw ModelError.fileTooLarge(fileName: fileName)
        }

        _data = fileName
        
    }
    
    public func form(multipart: MultipartFormData) {
        
        let url = URL(string: _data!)
        multipart.append(url!, withName: "data")
        
    }
    
}
