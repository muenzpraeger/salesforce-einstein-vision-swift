//
//  ApiUsage.swift
//  predictivevision
//
//  Created by René Winkelmeyer on 04/10/2017.
//  Copyright © 2017 René Winkelmeyer. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct ApiUsage {
    
    public var id: Int?
    public var organizationId: String?
    public var startsAt: String?
    public var endsAt: String?
    public var licenseId: String?
    public var predictionsMax: Double?
    public var predictionsRemaining: Double?
    public var predictionsUsed: Double?
    public var planData: [PlanData]?
    public var object: String?

    init?() {
    }
    
    init?(jsonObject: SwiftyJSON.JSON) {
        id = jsonObject["id"].int
        organizationId = jsonObject["organizationId"].string
        startsAt = jsonObject["startsAt"].string
        endsAt = jsonObject["endsAt"].string
        licenseId = jsonObject["licenseId"].string
        predictionsMax = jsonObject["predictionsMax"].double
        predictionsRemaining = jsonObject["predictionsRemaining"].double
        predictionsUsed = jsonObject["predictionsUsed"].double
        planData = [PlanData]()
        let jsonPlanData = jsonObject["planData"].array
        for object in jsonPlanData! {
            let plan = PlanData(jsonObject: object)
            planData?.append(plan!)
        }
        object = jsonObject["object"].string
    }
    
}
