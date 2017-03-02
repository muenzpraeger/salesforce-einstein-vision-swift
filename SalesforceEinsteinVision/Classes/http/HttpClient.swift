//
//  HttpClient.swift
//  predictivevision
//
//  Created by René Winkelmeyer on 02/28/2017.
//  Copyright © 2016 René Winkelmeyer. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HttpClient {
    
    private var service: PredictionService!
    private var url: String!
    
    var isDelete = false
    var isPost = false
    var part: MultiPart?
    
    init(service: PredictionService, url: String) {
        self.service = service
        self.url = url
    }
    
    init(service: PredictionService, url: String, part: MultiPart) {
        self.service = service
        self.url = url
        self.part = part
        isPost = true
    }
    
    func execute(completion: @escaping (Bool, String) -> Void) throws {
        if (url == nil) {
            throw GeneralError.failureReason(message: "No URL provided")
        }
        
        var headers: HTTPHeaders = [
            "Authorization": "Bearer " + service.bearerToken,
            "Cache-Control": "no-cache"
        ]
        
        if (isPost) {
            //let parts = self.part
            let parts = MultiPartDataset()
            headers.updateValue("Content-Type", forKey: "multipart/form-data")
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    parts.form(multipart: multipartFormData)
                },
                to: url,
                headers: headers,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseString { (request: DataResponse<String>) in
                            
                            var data: String = ""
                            var isSuccess = false
                            
                            let statusCode = NSNumber(value: (request.response?.statusCode)!)
                            
                            if let dataFromString = request.result.value!.data(using: .utf8, allowLossyConversion: false) {
                                let json = JSON(data: dataFromString)
                                
                                if (statusCode==400 || statusCode==200) {
                                    switch(statusCode) {
                                    case 200:
                                        _ = json["object"].stringValue
                                        switch(json["object"]) {
                                        case "list":
                                            data = json["data"].rawString()!
                                        default:
                                            data = request.result.value!
                                            print(data)
                                        }
                                        isSuccess = true
                                    default:
                                        data = json["message"].string!
                                    }
                                    completion(isSuccess, data)
                                } else {
                                    completion(isSuccess, data)
                                }
                                
                                
                            }
                        }
                        
                    case .failure(let encodingError):
                        print(encodingError)
                    }
                }
            )
        } else {
            
            var request: DataRequest
            
            if (isDelete) {
                request = Alamofire.request(url, method: .delete, headers: headers)
            } else {
                request = Alamofire.request(url, headers: headers)
            }
            
            request.responseString { (request: DataResponse<String>) in
                
                var data: String = ""
                var isSuccess = false
                
                let statusCode = NSNumber(value: (request.response?.statusCode)!)
                
                if let dataFromString = request.result.value!.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    
                    if (statusCode==400 || statusCode==200) {
                        switch(statusCode) {
                        case 200:
                            _ = json["object"].stringValue
                            switch(json["object"]) {
                            case "list":
                                data = json["data"].rawString()!
                            default:
                                data = request.result.value!
                                print(data)
                            }
                            isSuccess = true
                        default:
                            data = json["message"].string!
                        }
                    }
                    
                    completion(true, data)
                }
            }
            
            
        }
        
    }
    
}
