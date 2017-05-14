//
//  MultiPartPrediction.swift
//  Pods
//
//  Created by René Winkelmeyer on 02/28/2017.
//
//

import Alamofire
import Foundation

public enum SourceType {
    case file
    case base64
    case url
}

public struct MultiPartPrediction : MultiPart {
    
    private var _modelId:String?
    private var _data:String?
    private var _sampleId:String?
    private var _sourceType:SourceType?
   
    public init() {}
    
    public mutating func build(modelId: String, data: String, sampleId: String?, type: SourceType) {

        _modelId = modelId
        _data = data
        
        if let sampleId = sampleId, !sampleId.isEmpty {
            _sampleId = sampleId
        } 
    
        _sourceType = type
       
    }
    
    public func form(multipart: MultipartFormData) {
        
        let modelId = _modelId?.data(using: String.Encoding.utf8)
        multipart.append(modelId!, withName: "modelId")
        
        if let id = _sampleId, !id.isEmpty {
            let sampleId = id.data(using: String.Encoding.utf8)!
            multipart.append(sampleId, withName: "sampleId")
        }
        
        switch(_sourceType!) {
        case .base64:
            let dataPrediction = _data?.data(using: String.Encoding.utf8)
            multipart.append(dataPrediction!, withName: "sampleBase64Content")
            break
        case .file:
            let url = URL(string: _data!)
            multipart.append(url!, withName: "sampleContent")
            break
        case .url:
            let dataPrediction = _data?.data(using: String.Encoding.utf8)
            multipart.append(dataPrediction!, withName: "sampleLocation")
        }

    }
    
}
