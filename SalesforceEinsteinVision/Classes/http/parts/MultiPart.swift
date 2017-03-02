//
//  MultiPartDataset.swift
//  Pods
//
//  Created by René Winkelmeyer on 02/28/2017.
//
//

import Alamofire

protocol MultiPart {
    
    func form(multipart: MultipartFormData)
    
}
