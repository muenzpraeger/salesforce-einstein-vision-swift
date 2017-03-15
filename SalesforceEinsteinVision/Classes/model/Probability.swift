//
//  Probability.swift
//  predictivevision
//
//  Created by René Winkelmeyer on 02/28/2017.
//  Copyright © 2016 René Winkelmeyer. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Probability {
    
    public var label: String?
    public var probability: Float?
    
    init?() {
    }
    
    init?(jsonObject: SwiftyJSON.JSON) {
        label = jsonObject["label"].string
        probability = jsonObject["probability"].float
    }
    
}
