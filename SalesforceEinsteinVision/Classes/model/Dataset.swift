//
//  Dataset.swift
//  predictivevision
//
//  Created by René Winkelmeyer on 02/28/2017.
//  Copyright © 2016 René Winkelmeyer. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Dataset {
    
    public var available: Bool?
    public var id: Int?
    public var name: String?
    public var createdAt: String?
    public var updatedAt: String?
    public var statusMsg: String?
    public var labelSummary: LabelSummary?
    public var totalExamples: Int?
    public var totalLabels: Int?
    public var object: String?
    public var type: String?

    init?() {
    }
    
    init?(jsonObject: SwiftyJSON.JSON) {
        available = jsonObject["available"].bool
        id = jsonObject["id"].int
        name = jsonObject["name"].string
        createdAt = jsonObject["createdAt"].string
        updatedAt = jsonObject["updatedAt"].string
        statusMsg = jsonObject["statusMsg"].string
        labelSummary = LabelSummary(jsonObject: jsonObject["labelSummary"])
        totalExamples = jsonObject["totalExamples"].int
        totalLabels = jsonObject["totalLabels"].int
        object = jsonObject["object"].string
        type = jsonObject["type"].string
    }
    
}
