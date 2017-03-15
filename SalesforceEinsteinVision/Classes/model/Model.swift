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
    
    public var datasetId: Int?
    public var datasetVersionId: Int?
    public var name: String?
    public var status: String?
    public var progress: Int?
    public var createdAt: String?
    public var updatedAt: String?
    public var learningRate: Double?
    public var epochs: Int?
    public var queuePosition: Int?
    public var object: String?
    public var modelId: String?
    public var modelType: String?
    public var failureMsg: String?
    public var trainParams: String?
    public var trainStats: String?
    
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
