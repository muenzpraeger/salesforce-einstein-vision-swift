//
//  Model.swift
//  predictivevision
//
//  Created by René Winkelmeyer on 02/28/2017.
//  Copyright © 2016 René Winkelmeyer. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Model {
    
    var datasetId: Int?
    var datasetVersionId: Int?
    var name: String?
    var status: String?
    var progress: Int?
    var createdAt: String?
    var updatedAt: String?
    var learningRate: Double?
    var epochs: Int?
    var queuePosition: Int?
    var object: String?
    var modelId: String?
    var modelType: String?
    var failureMsg: String?
    var trainParams: String?
    var trainStats: String?
    
    init?() {
    }
    
    init?(jsonObject: SwiftyJSON.JSON) {
        datasetId = jsonObject["datasetId"].int
        datasetVersionId = jsonObject["datasetVersionId"].int
        name = jsonObject["name"].string
        status = jsonObject["status"].string
        progress = jsonObject["progress"].int
        createdAt = jsonObject["createdAt"].string
        updatedAt = jsonObject["updatedAt"].string
        learningRate = jsonObject["learningRate"].double
        epochs = jsonObject["epochs"].int
        queuePosition = jsonObject["queuePosition"].int
        object = jsonObject["object"].string
        modelId = jsonObject["modelId"].string
        modelType = jsonObject["modelType"].string
        failureMsg = jsonObject["failureMsg"].string
        trainParams = jsonObject["trainParams"].string
        trainStats = jsonObject["trainStatus"].string
    }
    
}
