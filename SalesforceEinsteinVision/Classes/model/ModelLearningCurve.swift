//
//  ModelLearningCurve.swift
//  einsteinvision
//
//  Created by René Winkelmeyer on 03/23/2017.
//  Copyright © 2016 René Winkelmeyer. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct ModelLearningCurve {
    
    public var epoch: Int?
    public var epochResults: [EpochResult]?
    public var metricsData: [ModelMetrics]?
    
    init?() {
    }
    
    init?(jsonObject: SwiftyJSON.JSON) {
        epoch = jsonObject["epoch"].int
        epochResults = [EpochResult]()
        let jsonEpochResults = jsonObject["epochResults"].array
        for object in jsonEpochResults! {
            let epochResult = EpochResult(jsonObject: object)
            epochResults?.append(epochResult!)
        }
        metricsData = [ModelMetrics]()
        let jsonModelMetrics = jsonObject["metricsData"].array
        for object in jsonModelMetrics! {
            let metric = ModelMetrics(jsonObject: object)
            metricsData?.append(metric!)
        }
    }
    
}
