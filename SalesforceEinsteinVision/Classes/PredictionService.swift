import Foundation
import SwiftyJSON
import Alamofire

public class PredictionService {
    
    private let BASE_URL = "https://api.metamind.io/v1/vision"
    private var DATASETS: String
    private let LABELS = "/labels"
    private var EXAMPLES: String = "/examples"
    private let TRAIN: String = "/train"
    private let MODELS: String = "/models"
    private var PREDICT: String
    
    var bearerToken = ""
    
    /// Create a new object of type PredictionService.
    ///
    /// The PredictionService is the foundatrio for communicating with the Salesforc Einstein Prediction Service.
    ///
    /// As a pre-requisite for using the service a valid Bearer token passed to the initialization.
    //
    /// - Parameter bearerToken: A valid Bearer token
    public init?(bearerToken: String) {
        if (bearerToken.isEmpty) {
            return nil
        }
        self.bearerToken = bearerToken
        DATASETS = BASE_URL + "/datasets"
        PREDICT = BASE_URL + "/predict"
    }
    
    // MARK: Datasets
    
    /// Creates a new Dataset. A Dataset is basically a group of different object types (named as "Label").
    ///
    /// - Parameters:
    ///   - name: The name of the Dataset
    ///   - labels: An array of labels that will be used in the Dataset, i. e. "Beaches", "Mountains" etc.
    ///   - completion: Returns a Dataset object
    public func createDataset(name: String, labels: [String], completion:@escaping (Dataset?) -> Void) -> Void {
        do {
            var multiPart = MultiPartDataset()
            try multiPart.build(name: name, labels: labels)
            try HttpClient(service: self, url: DATASETS, part: multiPart).execute { (success, result) in
                if (success == false) {
                    completion(nil)
                    return
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let dataset = Dataset(jsonObject: json)
                    completion(dataset)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
        
    }
    
    /// Creates a new Dataset based on a local zip file. A Dataset is basically a group of different object types (named as "Label").
    ///
    /// - Parameters:
    ///   - fileName: The full filepath + name of the zip file
    ///   - completion: Returns a Dataset object
    public func createDatasetFromZipFileAsync(fileName: String, completion:@escaping (Dataset?) -> Void) -> Void {
        do {
            var multiPart = MultiPartDatasetZipFile()
            try multiPart.build(fileName: fileName)
            try HttpClient(service: self, url: DATASETS + "/upload", part: multiPart).execute { (success, result) in
                if (success == false) {
                    completion(nil)
                    return
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let dataset = Dataset(jsonObject: json)
                    completion(dataset)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
        
    }
    
    /// Creates a new Dataset based on a local zip file. A Dataset is basically a group of different object types (named as "Label").
    ///
    /// - Parameters:
    ///   - fileName: The full filepath + name of the zip file
    ///   - completion: Returns a Dataset object
    public func createDatasetFromZipFileSync(fileName: String, completion:@escaping (Dataset?) -> Void) -> Void {
        do {
            var multiPart = MultiPartDatasetZipFile()
            try multiPart.build(fileName: fileName)
            try HttpClient(service: self, url: DATASETS + "/upload/sync", part: multiPart).execute { (success, result) in
                if (success == false) {
                    completion(nil)
                    return
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let dataset = Dataset(jsonObject: json)
                    completion(dataset)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
        
    }
    
    /// Creates a new Dataset based on a remote zip file. A Dataset is basically a group of different object types (named as "Label").
    ///
    /// - Parameters:
    ///   - url: The remote url of the zip file.
    ///   - completion: Returns a Dataset object
    public func createDatasetFromUrlAsync(url: String, completion:@escaping (Dataset?) -> Void) -> Void {
        do {
            var multiPart = MultiPartDatasetUrl()
            try multiPart.build(url: url)
            try HttpClient(service: self, url: DATASETS + "/upload", part: multiPart).execute { (success, result) in
                if (success == false) {
                    completion(nil)
                    return
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let dataset = Dataset(jsonObject: json)
                    completion(dataset)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
        
    }
    
    /// Creates a new Dataset based on a remote zip file. A Dataset is basically a group of different object types (named as "Label").
    ///
    /// - Parameters:
    ///   - url: The remote url of the zip file.
    ///   - completion: Returns a Dataset object
    public func createDatasetFromUrlSync(url: String, completion:@escaping (Dataset?) -> Void) -> Void {
        do {
            var multiPart = MultiPartDatasetUrl()
            try multiPart.build(url: url)
            try HttpClient(service: self, url: DATASETS + "/upload/sync", part: multiPart).execute { (success, result) in
                if (success == false) {
                    completion(nil)
                    return
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let dataset = Dataset(jsonObject: json)
                    completion(dataset)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
        
    }
    
    /// Gets an existing Dataset.
    ///
    /// - Parameters:
    ///   - id: The id of the Dataset that needs to be fetched.
    ///   - completion: Returns the fetched Dataset
    public func getDataset(id: Int, completion:@escaping (Dataset?) -> Void) -> Void {
        do {
            try HttpClient(service: self, url: DATASETS + "/" + String(id)).execute { (success, result) in
                if (!success) {
                    completion(nil)
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let dataset = Dataset(jsonObject: json)
                    completion(dataset)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
    /// Gets all Datasets of the authenticated user.
    ///
    /// - Parameter completion: An array of all Datasets
    public func getDatasets(completion:@escaping ([Dataset]?) -> Void) -> Void {
        do {
            try HttpClient(service: self, url: DATASETS).execute { (success, result) in
                if (!success) {
                    completion(nil)
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    
                    var datasets = [Dataset]()
                    
                    for object in json.array! {
                        let dataset = Dataset(jsonObject: object)
                        datasets.append(dataset!)
                    }
                    completion(datasets)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
    /// Deletes an existing dataset.
    ///
    /// - Parameters:
    ///   - id: The id of the Dataset that should be deleted.
    ///   - completion: True if the deletion was successful.
    public func deleteDataset(id: Int, completion:@escaping (Bool?) -> Void) -> Void {
        do {
            try HttpClient(service: self, url: DATASETS).execute { (success, result) in
                if (!success) {
                    completion(false)
                }
                completion(true)
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
    // MARK: Labels
    
    /// reates a new Label within an existing Dataset.
    ///
    /// - Parameters:
    ///   - datasetId: The id of the Dataset.
    ///   - name: The new Label name.
    ///   - completion: The created Label
    public func createLabel(datasetId: Int, name: String, completion:@escaping (Label?) -> Void) -> Void {
        do {
            var multiPart = MultiPartLabel()
            try multiPart.build(name: name)
            try HttpClient(service: self, url: DATASETS + "/" + String(datasetId) + LABELS, part: multiPart).execute { (success, result) in
                if (!success) {
                    completion(nil)
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let label = Label(jsonObject: json)
                    completion(label)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
    /// Gets an existing Label from a Dataset.
    ///
    /// - Parameters:
    ///   - datasetId: The id of the associated Dataset.
    ///   - id: The id of the Dataset that needs to be fetched.
    ///   - completion: The fetched Label
    public func getLabel(datasetId: Int, id: Int, completion:@escaping (Label?) -> Void) -> Void {
        do {
            try HttpClient(service: self, url: DATASETS + "/" + String(datasetId) + LABELS + String(id)).execute { (success, result) in
                if (!success) {
                    completion(nil)
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let label = Label(jsonObject: json)
                    completion(label)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
    // MARK: Examples
    
    /// Adds a new image example for the predictive vision training.
    ///
    /// - Parameters:
    ///   - datasetId: The id of the Dataset to which the image should be added.
    ///   - name: The name of the image.
    ///   - labelId: The label to which the image should be associated.
    ///   - data: The full file path of the image.
    ///   - completion: The Example object
    public func createExample(datasetId: Int, name: String, labelId: Int, data: String, completion:@escaping (Example?) -> Void) -> Void {
        do {
            var multiPart = MultiPartExample()
            try multiPart.build(name: name, labelId: labelId, file: URL(string: data)!)
            try HttpClient(service: self, url: DATASETS + "/" + String(datasetId) + EXAMPLES, part: multiPart).execute { (success, result) in
                if (!success) {
                    completion(nil)
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let example = Example(jsonObject: json)
                    completion(example)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
    /// Adds new image examples for the vision training from a local zip file.
    ///
    /// - Parameters:
    ///   - datasetId: The id of the Dataset to which the image should be added.
    ///   - fileName: The local file path of the zip file.
    ///   - completion: The Example object
    public func createExampleFromZipFile(datasetId: Int, fileName: String, completion:@escaping (Example?) -> Void) -> Void {
        do {
            var multiPart = MultiPartDatasetZipFile()
            try multiPart.build(fileName: fileName)
            try HttpClient(service: self, url: DATASETS + "/" + String(datasetId) + "/upload", part: multiPart).execute { (success, result) in
                if (!success) {
                    completion(nil)
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let example = Example(jsonObject: json)
                    completion(example)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
    /// Adds new image examples for the vision training from a remote zip file.
    ///
    /// - Parameters:
    ///   - datasetId: The id of the Dataset to which the image should be added.
    ///   - url: The remote url of the zip file.
    ///   - completion: The Example object
    public func createExample(datasetId: Int, url: String, completion:@escaping (Example?) -> Void) -> Void {
        do {
            var multiPart = MultiPartDatasetUrl()
            try multiPart.build(url: url)
            try HttpClient(service: self, url: DATASETS + "/" + String(datasetId) + "/upload", part: multiPart).execute { (success, result) in
                if (!success) {
                    completion(nil)
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let example = Example(jsonObject: json)
                    completion(example)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
    /// Gets data about an existing example.
    ///
    /// - Parameters:
    ///   - datasetId: The id of the Dataset to which the Examples are associated.
    ///   - id: The id of the Example.
    ///   - completion: The fetched Example object
    public func getExample(datasetId: Int, id: Int, completion:@escaping (Example?) -> Void) -> Void {
        do {
            try HttpClient(service: self, url: DATASETS + String(datasetId) + EXAMPLES + "/" + String(id)).execute { (success, result) in
                if (!success) {
                    completion(nil)
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let example = Example(jsonObject: json)
                    completion(example)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
    
    /// Gets an array of all Examples that are associated with the given Dataset.
    ///
    /// - Parameters:
    ///   - datasetId: The id of the Dataset to which the Examples are associated.
    ///   - completion: An array of Examples
    public func getExamples(datasetId: Int, completion:@escaping ([Example]?) -> Void) -> Void {
        do {
            try HttpClient(service: self, url: DATASETS + "/" + String(datasetId) + EXAMPLES).execute { (success, result) in
                if (!success) {
                    completion(nil)
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    
                    var examples = [Example]()
                    
                    for object in json.array! {
                        let example = Example(jsonObject: object)
                        examples.append(example!)
                    }
                    completion(examples)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
    /// Deletes the given Example.
    ///
    /// - Parameters:
    ///   - datasetId: The Dataset id to which the Example belongs.
    ///   - id: The id of the Example that needs to be deleted.
    ///   - completion: True if the deletion was successful
    public func deleteExample(datasetId: Int, id: Int, completion:@escaping (Bool?) -> Void) -> Void {
        do {
            try HttpClient(service: self, url: DATASETS + "/" + String(datasetId) + EXAMPLES + "/" + String(id)).execute { (success, result) in
                if (!success) {
                    completion(false)
                }
                completion(true)
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
    // MARK: Models / Training
    
    /// Starts the training of a Dataset.
    ///
    /// - Parameters:
    ///   - datasetId: The Dataset id that should be trained.
    ///   - name: The name of the training.
    ///   - epochs: Optional. The number of training iterations, valid values are between 1-100. Set to 0 if you want to use the default.
    ///   - learningRate: Optional. The learning rate, valid values are betweed 0.0001 and 0.01. Set to 0 if you want to use the default.
    ///   - completion: The trained Model
    public func trainDataset(datasetId: Int, name: String, epochs: Int, learningRate: Double, trainParams: String, completion:@escaping (Model?) -> Void) -> Void {
        do {
            var multiPart = MultiPartTraining()
            try multiPart.build(datasetId: datasetId, name: name, epochs: epochs, learningRate: learningRate, trainParams: trainParams)
            try HttpClient(service: self, url: TRAIN, part: multiPart).execute { (success, result) in
                if (!success) {
                    completion(nil)
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let model = Model(jsonObject: json)
                    completion(model)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
    /// Fetches the model for the given id.
    ///
    /// - Parameters:
    ///   - modelId: The id of the model that needs to be fetched.
    ///   - completion: The fetched Model object
    public func getModel(modelId: String, completion:@escaping (Model?) -> Void) -> Void {
        do {
            try HttpClient(service: self, url: TRAIN + "/" + modelId).execute { (success, result) in
                if (!success) {
                    completion(nil)
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let model = Model(jsonObject: json)
                    completion(model)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
    /// Gets the metrics of a Model.
    ///
    /// - Parameters:
    ///   - modelMetricsId: The model id for which the metrics should be fetched.
    ///   - completion: The fetched Model metrics
    public func getModelMetrics(modelMetricsId: String, completion:@escaping (ModelMetrics?) -> Void) -> Void {
        do {
            try HttpClient(service: self, url: MODELS + "/" + modelMetricsId).execute { (success, result) in
                if (!success) {
                    completion(nil)
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let modelMetrics = ModelMetrics(jsonObject: json)
                    completion(modelMetrics)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
    /// Gets all trained Models that are trained for the given Dataset.
    ///
    /// - Parameters:
    ///   - datasetId: The Dataset id to which the Models are assigned.
    ///   - completion: An array of Models
    public func getModels(datasetId: Int, completion:@escaping ([Model]?) -> Void) -> Void {
        do {
            try HttpClient(service: self, url: DATASETS + "/" + String(datasetId) + "/" + MODELS).execute { (success, result) in
                if (!success) {
                    completion(nil)
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    
                    var models = [Model]()
                    
                    for object in json.array! {
                        let model = Model(jsonObject: object)
                        models.append(model!)
                    }
                    completion(models)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
    // MARK: Prediction
    
    /// Predicts the association of the given image in Base64 format to a trained model.
    ///
    /// - Parameters:
    ///   - modelId: The Model that should be used for the prediction.
    ///   - base64: The image that should be predicted.
    ///   - sampleId: Optional. A string that gets returned as an association with the predicted image.
    ///   - completion: The PredictionResult for this prediction.
    public func predictBase64(modelId: String, base64: String, sampleId: String?, completion:@escaping (PredictionResult?) -> Void) -> Void {
        do {
            var multiPart = MultiPartPrediction()
            try multiPart.build(modelId: modelId, data: base64, sampleId: sampleId!, type: SourceType.base64)
            try HttpClient(service: self, url: PREDICT, part: multiPart).execute { (success, result) in
                if (!success) {
                    completion(nil)
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let predictionResult = PredictionResult(jsonObject: json)
                    completion(predictionResult)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
    /// Predicts the association of the given image on the local file system to a trained model.
    ///
    /// - Parameters:
    ///   - modelId: The Model that should be used for the prediction.
    ///   - filePath: The absolute file path of the local image.
    ///   - sampleId: Optional. A string that gets returned as an association with the predicted image.
    ///   - completion: The PredictionResult for this prediction.
    public func predictFile(modelId: String, filePath: String, sampleId: String?, completion:@escaping (PredictionResult?) -> Void) -> Void {
        do {
            var multiPart = MultiPartPrediction()
            try multiPart.build(modelId: modelId, data: filePath, sampleId: sampleId!, type: SourceType.file)
            try HttpClient(service: self, url: PREDICT, part: multiPart).execute { (success, result) in
                if (!success) {
                    completion(nil)
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let predictionResult = PredictionResult(jsonObject: json)
                    completion(predictionResult)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
    /// Predicts the association of the given image on a remote url m to a trained model.
    ///
    /// - Parameters:
    ///   - modelId: The Model id that should be used for the prediction.
    ///   - url: The absolute url of the image.
    ///   - sampleId: Optional. A string that gets returned as an association with the predicted image.
    ///   - completion: The PredictionResult for this prediction.
    public func predictUrl(modelId: String, url: String, sampleId: String?, completion:@escaping (PredictionResult?) -> Void) -> Void {
        do {
            var multiPart = MultiPartPrediction()
            try multiPart.build(modelId: modelId, data: url, sampleId: sampleId!, type: SourceType.url)
            try HttpClient(service: self, url: PREDICT, part: multiPart).execute { (success, result) in
                if (!success) {
                    completion(nil)
                }
                
                if let dataFromString = result.data(using: .utf8, allowLossyConversion: false) {
                    let json = JSON(data: dataFromString)
                    let predictionResult = PredictionResult(jsonObject: json)
                    completion(predictionResult)
                }
            }
        } catch GeneralError.failureReason(let message){
            print(message)
        } catch {
            print("Unknown error")
        }
    }
    
}

