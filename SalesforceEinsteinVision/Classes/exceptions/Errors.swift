//
//  ModelErrors.swift
//  predictivevision
//
//  Created by René Winkelmeyer on 02/28/2017.
//  Copyright © 2016 René Winkelmeyer. All rights reserved.
//

import Foundation

public enum ModelError: Error {
 
    case noFieldValue(field: String)
    case intTooBig(field: String, maxValue: Int, currentValue: Int)
    case doubleTooBig(field: String, maxValue: Double, currentValue: Double)
    case intTooSmall(field: String, minValue: Int, currentValue: Int)
    case doubleTooSmall(field: String, minValue: Double, currentValue: Double)
    case stringTooLong(field: String, maxValue: Int, currentValue: Int)
    case tooManyValues(field: String, maxValue: Int, currentValue: Int)
    case noValues(fields: String)
    case fileDoesNotExist(fileName: String)
    case fileNoZipFile(fileName: String)
    case fileTooLarge(fileName: String)
    case noUrl(url: String)
    
}

public enum GeneralError: Error {
    
    case failureReason(message: String)
    
}
