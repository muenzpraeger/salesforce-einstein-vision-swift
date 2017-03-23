//
//  ModelMetrics.swift
//  predictivevision
//
//  Created by René Winkelmeyer on 02/28/2017.
//  Copyright © 2016 René Winkelmeyer. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct ModelMetrics {
    
    public var f1: [Double]?
    public var testAccuracy: Double?
    public var trainingLoss: Double?
    public var confusionMatrix: [Int]?
    public var trainingAccuracy: String?
    public var labels: [String]?
    
    init?() {
    }
    
    init?(jsonObject: SwiftyJSON.JSON) {
        f1 = [Double]()
        let jsonF1 = jsonObject["f1"].array
        for object in jsonF1! {
            let value = object.double
            f1?.append(value!)
        }
        testAccuracy = jsonObject["testAccuracy"].double
        trainingLoss = jsonObject["trainingLoss"].double
        confusionMatrix = [Int]()
        let jsonConfusionMatrix = jsonObject["confusionMatrix"].array
        for object in jsonConfusionMatrix! {
            let value = object.int
            confusionMatrix?.append(value!)
        }
        labels = [String]()
        let jsonLabels = jsonObject["labels"].array
        for object in jsonLabels! {
            let value = object.string
            labels?.append(value!)
        }
        trainingAccuracy = jsonObject["trainingAccuracy"].string
    }
    
}
