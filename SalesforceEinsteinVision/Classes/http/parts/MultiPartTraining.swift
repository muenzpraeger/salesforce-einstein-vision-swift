//
//  MultiPartTraining.swift
//  Pods
//
//  Created by René Winkelmeyer on 02/28/2017.
//
//

import Alamofire
import Foundation

public struct MultiPartTraining : MultiPart {
    
    private let DEFAULT_LEARNING_RATE = 0.0001
    private let MIN_LEARNING_RATE = 0.0001
    private let MAX_LEARNING_RATE = 0.01
    private let MAX_NAME = 180
    
    private var _datasetId:Int?
    private var _name:String?
    private var _epochs:Int?
    private var _learningRateChecked:Double?
    private var _trainParams:String?
    
    public init() {}
    
    public mutating func build(datasetId: Int, name: String, epochs: Int, learningRate: Double, trainParams: String) throws {
        
        if (datasetId==0) {
            throw ModelError.noFieldValue(field: "datasetId")
        }
        if name.isEmpty {
            throw ModelError.noFieldValue(field: "name")
        }
        if (name.characters.count>MAX_NAME) {
            throw ModelError.stringTooLong(field: "name", maxValue: MAX_NAME, currentValue: name.characters.count)
        }
        if (epochs>100) {
            throw ModelError.intTooBig(field: "epochs", maxValue: 100, currentValue: epochs)
        }
        
        var learningRateChecked = learningRate
        
        if (learningRateChecked==0) {
            learningRateChecked = DEFAULT_LEARNING_RATE
        } else if (learningRateChecked<MIN_LEARNING_RATE) {
            throw ModelError.doubleTooSmall(field: "learningRate", minValue: MIN_LEARNING_RATE, currentValue: learningRateChecked)
        } else if (learningRateChecked>MAX_LEARNING_RATE) {
            throw ModelError.doubleTooBig(field: "learningRate", maxValue: MAX_LEARNING_RATE, currentValue: learningRateChecked)
        }
        
        _datasetId = datasetId
        _name = name
        _epochs = epochs
        _learningRateChecked = learningRateChecked
        _trainParams = trainParams
        
    }
    
    public func form(multipart: MultipartFormData) {
        
        let nameData = _name?.data(using: String.Encoding.utf8)
        multipart.append(nameData!, withName: "name")
        
        if (_epochs!>0) {
            let epochsData = (String(describing: _epochs)).data(using: String.Encoding.utf8)
            multipart.append(epochsData!, withName: "epochs")
        }
        
        let learningRateData = (String(describing: _learningRateChecked)).data(using: String.Encoding.utf8)
        multipart.append(learningRateData!, withName: "learningRate")
        
        if (!_trainParams!.isEmpty) {
            let trainParamsData = _trainParams?.data(using: String.Encoding.utf8)
            multipart.append(trainParamsData!, withName: "trainParamsData")
        }
        
    }
    
}
