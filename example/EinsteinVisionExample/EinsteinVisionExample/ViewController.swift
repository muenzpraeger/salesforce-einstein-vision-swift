//
//  ViewController.swift
//  EinsteinVisionExample
//
//  Created by René Winkelmeyer on 15/03/2017.
//  Copyright © 2017 René Winkelmeyer. All rights reserved.
//

import UIKit
import SalesforceEinsteinVision

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker: UIImagePickerController!
    

    @IBOutlet weak var analysisText: UITextView!
    
    @IBAction func takeAndAnalyzePhoto(_ sender: UIButton) {
        
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = chosenImage
        dismiss(animated: true, completion: nil)
        
        // convert UIImage to base64
        let imageData = UIImageJPEGRepresentation(chosenImage, 0.4)! as NSData
        let imageStr = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))

        
        // Initialize the service with a valid access token
        let service = PredictionService(bearerToken: "enterYourValidBearerTokenHere")
        
        // Upload base64 for prediction on the General Image Classifier Model
        service?.predictBase64(modelId: "GeneralImageClassifier", base64: imageStr, sampleId: "", completion: { (result) in

            var resultString = ""
            
            if (result != nil) {
                for prob in (result?.probabilities!)! {
                    resultString = resultString + prob.label! + " (" + String(prob.probability!) + ")\n"
                }
            } else {
                resultString = "No data found"
            }

            self.analysisText.text = resultString
            
        })
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

