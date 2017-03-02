# salesforce-einstein-vision-swift

[![Version](https://img.shields.io/cocoapods/v/SalesforceEinsteinVision.svg?style=flat)](http://cocoapods.org/pods/SalesforceEinsteinVision)
[![License](https://img.shields.io/cocoapods/l/SalesforceEinsteinVision.svg?style=flat)](http://cocoapods.org/pods/SalesforceEinsteinVision)
[![Platform](https://img.shields.io/cocoapods/p/SalesforceEinsteinVision.svg?style=flat)](http://cocoapods.org/pods/SalesforceEinsteinVision)


This repository showcases how to use the [Salesforce Einstein Vision API](https://metamind.readme.io/) using a Swift based wrapper.

Please check the [product documentation](https://metamind.readme.io/) for general information about what the Salesforce Einstein Vision API is, how to use it and when it'll be available for you.

# Run-On-Your-Own

## Prerequisites

For running the app on your own you'll need to fulfill the following requirements:
* Access to a Salesforce org, i. e. a Developer Edition (You can [signup here for free](https://developer.salesforce.com/signup) if you don't have one).
* An API account for Salesforce MetaMind.

Please find the detailed instructions for how to setup access to the [MetaMind API here](https://metamind.readme.io/docs/what-you-need-to-call-api).

## Installation

SalesforceEinsteinVision is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod "SalesforceEinsteinVision"
```

## Getting started

As this library is basically a wrapper for using the [Salesforce Einstein Vision API](https://metamind.readme.io/) it is highly recommended to checkout the API documentation.

The workflow for using Einstein Vision can be described with the following scenario.

* First you identify image categories that need to be identified (i. e. Beaches, Mountains etc.).
* Then you create a dataset which will hold all those image categories.
* You add for each identified image category a so called "label" to the dataset.
* For every label you add a number of example images to the dataset.
* After you've finished adding examples you can train the dataset.
* After the training you can start to predict if a given image belongs to one of the defined labels.

Please check the MetaMind documentation for recommendations regarding image quality, amount of examples and so forth.

### Creating a PredictionService

The foundation for everything is the `PredictionService`. As the communication with the API is based on a valid OAuth2 token (see MetaMind documentation) you can initiate a new PredictionService in two ways.

```
let predictionService = PredictionService()
```
or
```
let predictionService = PredictionService(bearerToken: "AASDFNSADF23423424SADSFASF")
```

Based on your needs you can pass the OAuth2 token either as parameter (see 2nd example). Or you set it as an environment variable. In this case you don't have to pass the token.

### Creating a first Dataset

For creating a Dataset you call
```
let ds = service?.createDataset(name: "theDatasetName", labels: ["aa", "bb"], completion: { (result) in
    })
```
If you decide later to add more labels (aka categories) to the Dataset you can do that via an available `createLabel` method.

### Adding Examples

For adding an Example to a Dataset you have to execute this call.#
```
let example = service.createExample(datasetId: theDatasetId, name: "label", labelId: theLabelId, data: "localFilePath") { (result) in
}
```
This will upload the file to the Dataset for the training.

### Train the Dataset

After you've added all Examples you can train the Dataset via
```
let model = service.trainDataset(datasetId: theDatasetId, name: "yourCustomTrainingName", epochs: 0, learningRate: 0) { (result) in
    }
```
This will start the training process on the server.

### Predict an image

You can predict images either by sending Base64, uploading a local file or a remote (publicly available!) URL. See this example how to validate a remote URL.

```
let result = service.predictUrl(modelId: "theModelId", url: "theUrl", sampleId: "") { (result) in
    }
```

The returned result will give you an array of all Labels within the Dataset and their probability.

Checkout the aforementioned example code for a complete process.

## Contribution

Feel free to contribute to this project via pull requests.

## License

For licensing see the included [license file](https://github.com/muenzpraeger/salesforce-einstein-vision-swift/blob/master/LICENSE.md).
