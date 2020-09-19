//
//  ViewController.swift
//  FaceDetectionML
//
//  Created by Furkan Hanci on 9/19/20.
//

import UIKit
import Vision

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard  let image =  UIImage(named: "steve") else { return }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        let scaleHeight =  view.frame.width / image.size.width * image.size.height
        
        imageView.frame = CGRect(x: 0, y: 70, width: view.frame.width, height: scaleHeight)
        
        view.addSubview(imageView)
        
        
        let request =  VNDetectFaceRectanglesRequest { (request, error) in
            
            if let error = error {
                print("Fail" , error)
                 
                return
            }
            
            print(request)
            request.results?.forEach({ (res) in
                
                DispatchQueue.main.async {
                    
                    print(res)
                    
                    guard let faceObservation = res as? VNFaceObservation else { return }
                    
                   
                    
                    let x =  self.view.frame.width * faceObservation.boundingBox.origin.x
                    
                    let height = self.view.frame.height * faceObservation.boundingBox.height
                    
                    let width = self.view.frame.width * faceObservation.boundingBox.width
                    
                    let y = scaleHeight * ( 1 - faceObservation.boundingBox.height)
                    
                  
                    
                     let redView = UIView()
                    redView.backgroundColor = .red
                    redView.alpha = 0.4
                    redView.frame = CGRect(x: x, y: y, width : width, height: height)
                    self.view.addSubview(redView)
                   
                    
                    print(faceObservation.boundingBox)
                }
                
             
            })
            
        }
        
        guard let cgImage = image.cgImage else { return }
        
        DispatchQueue.global(qos: .background).async {
         
            let handler =  VNImageRequestHandler(cgImage: cgImage, options: [:])
             
             do {
                try handler.perform([request])
             } catch let requesterr {
                 print("Fail request" , requesterr)
             }
            
        }
        
     
        
       
        
    }


}

