//
//  EpochResult.swift
//  einsteinvision
//
//  Created by René Winkelmeyer on 03/23/2017.
//  Copyright © 2016 René Winkelmeyer. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct EpochResult {
    
    public var exampleName: String?
    public var exampleLabel: String?
    public var predictedLabel: String?
    
    init?() {
    }
    
    init?(jsonObject: SwiftyJSON.JSON) {
        exampleName = jsonObject["exampleName"].string
        exampleLabel = jsonObject["exampleLabel"].string
        predictedLabel = jsonObject["predictedLabel"].string
    }
    
}
