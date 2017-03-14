//
//  MultiPartDatasetUrl.swift
//  EinsteinVisionFramer
//
//  Created by René Winkelmeyer on 14/03/2017.
//  Copyright © 2017 René Winkelmeyer. All rights reserved.
//

import Alamofire
import Foundation

public struct MultiPartDatasetUrl : MultiPart {
    
    private var _url:String?
    
    public init() {}
    
    public mutating func build(url: String) throws {
        
        if url.isEmpty {
            throw ModelError.noFieldValue(field: "url")
        }
        let types: NSTextCheckingResult.CheckingType = .link
        
        let detector = try? NSDataDetector(types: types.rawValue)
        
        let matches = detector?.matches(in: url, options: .reportCompletion, range: NSMakeRange(0, url.characters.count))
        
        var isURL = false
        
        for match in matches! {
            isURL = true
        }
        
        if (!isURL) {
            throw ModelError.noUrl(url: url)
        }
        
        _url = url
        
    }
    
    public func form(multipart: MultipartFormData) {
        
        let data = _url?.data(using: String.Encoding.utf8)
        multipart.append(data!, withName: "path")
        
    }
    
}

