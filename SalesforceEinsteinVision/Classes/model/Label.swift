//
//  Label.swift
//  predictivevision
//
//  Created by René Winkelmeyer on 02/28/2017.
//  Copyright © 2016 René Winkelmeyer. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Label {
    
    public var id: Int?
    public var datasetId: Int?
    public var name: String?
    public var numExamples: Int?
    public var object: String?
    
    init?() {
    }
    
    init?(jsonObject: SwiftyJSON.JSON) {
        id = jsonObject["id"].int
        datasetId = jsonObject["datasetId"].int
        name = jsonObject["name"].string
        numExamples = jsonObject["numExamples"].int
        object = jsonObject["object"].string
    }
    
}
