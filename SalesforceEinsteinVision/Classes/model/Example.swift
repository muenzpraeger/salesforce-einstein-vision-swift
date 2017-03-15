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
    
    public var id: Int?
    public var name: String?
    public var location: String?
    public var createdAt: String?
    public var label: Label?
    public var object: String?
    
    init?() {
    }
    
    init?(jsonObject: SwiftyJSON.JSON) {
        id = jsonObject["id"].int
        name = jsonObject["name"].string
        location = jsonObject["location"].string
        createdAt = jsonObject["createdAt"].string
        label = Label(jsonObject: jsonObject["label"])
        object = jsonObject["object"].string
    }
    
}
