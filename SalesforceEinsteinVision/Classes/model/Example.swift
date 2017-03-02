//
//  Example.swift
//  predictivevision
//
//  Created by René Winkelmeyer on 02/28/2017.
//  Copyright © 2016 René Winkelmeyer. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Example {
    
    var id: Int?
    var name: String?
    var createdAt: String?
    var label: Label?
    var object: String?
    
    init?() {
    }
    
    init?(jsonObject: SwiftyJSON.JSON) {
        id = jsonObject["id"].int
        name = jsonObject["name"].string
        createdAt = jsonObject["createdAt"].string
        label = Label(jsonObject: jsonObject["label"])
        object = jsonObject["object"].string
    }
    
}
