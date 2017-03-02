//
//  LabelSummary.swift
//  predictivevision
//
//  Created by René Winkelmeyer on 02/28/2017.
//  Copyright © 2016 René Winkelmeyer. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct LabelSummary {

    public var labels: [Label]?
    
    init?() {
    }
    
    init?(jsonObject: SwiftyJSON.JSON) {
        labels = [Label]()
        let jsonLabels = jsonObject["labels"].array
        for object in jsonLabels! {
            let label = Label(jsonObject: object)
            labels?.append(label!)
        }
    }
    
}
