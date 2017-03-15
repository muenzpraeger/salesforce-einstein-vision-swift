//
//  PredictionResult.swift
//  predictivevision
//
//  Created by René Winkelmeyer on 02/28/2017.
//  Copyright © 2016 René Winkelmeyer. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct PredictionResult {
    
    public var object: String?
    public var probabilities: [Probability]?
    
    init?() {
    }
    
    init?(jsonObject: SwiftyJSON.JSON) {
        probabilities = [Probability]()
        let jsonProbabilities = jsonObject["probabilities"].array
        for object in jsonProbabilities! {
            let probability = Probability(jsonObject: object)
            probabilities?.append(probability!)
        }
        object = jsonObject["object"].string
    }
    
}
