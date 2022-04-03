//
//  ViewController.swift
//  FacialRecognitionApp-iOS
//
//  Created by Ashkan Goharfar on 2022-04-03.
//

import UIKit
import Vision
import Photos

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var pictureChosen: UIImageView!
    
    
    let picker = UIImagePickerController()
    
    
    @IBAction func getImage(_ sender: UIButton) {
        getPhoto()
    }
    
    func getPhoto() {

        picker.allowsEditing = false
        picker.sourceType = .photoLibrary

        present(picker, animated: true, completion: nil)
            
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
               pictureChosen.contentMode = .scaleAspectFit
               pictureChosen.image = pickedImage
           }
    
           dismiss(animated: true, completion: nil)
       }
    
    
    func analyzeImage(image: UIImage)
    {
        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [ : ])
        messageLabel.text = "Analyzing picture..."
        let request =
        VNDetectFaceRectanglesRequest(completionHandler: handleFaceRecognition)
        try! handler.perform([request])
    }
    
    func handleFaceRecognition(request: VNRequest, error: Error?) {
        guard let foundFaces = request.results as? [VNFaceObservation] else {
            fatalError ("Can't find a face in the picture")
        }
        messageLabel.text = "Found \(foundFaces.count) faces in the picture"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.delegate = self
    }


}

