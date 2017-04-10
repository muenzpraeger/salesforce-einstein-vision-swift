//
//  PlanUsage.swift
//  predictivevision
//
//  Created by René Winkelmeyer on 04/10/2017.
//  Copyright © 2017 René Winkelmeyer. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct PlanData {
    
    public var plan: String?
    public var source: String?
    public var amount: Int?

    init?() {
    }
    
    init?(jsonObject: SwiftyJSON.JSON) {
        plan = jsonObject["plan"].string
        source = jsonObject["source"].string
        amount = jsonObject["amount"].int
    }
    
}
