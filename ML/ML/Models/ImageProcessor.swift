//
//  ImageProcessor.swift
//  ML
//
//  Created by Pamella Alvarenga on 31/07/24.
import UIKit
import Vision
import CoreML

class ImageProcessor {
    
    
    func isolateDrawing(from image: UIImage, completion: @escaping (UIImage?) -> Void) {
        do {
            let config = MLModelConfiguration()
            let model = try SeaAnimalClasses_1(configuration: config)
            let visionModel = try VNCoreMLModel(for: model.model)
            
            let classificationRequest = VNCoreMLRequest(model: visionModel) { (request, error) in
                if let error = error {
                    print("Error in VNCoreMLRequest: \(error)")
                    completion(nil)
                    return
                }
                
                guard let results = request.results as? [VNClassificationObservation],
                      let firstResult = results.first else {
                    print("Failed to classify the image")
                    completion(nil)
                    return
                }
                
//                print("results")
//                print(results)
//                print("firstResult")
//                print(firstResult)
//                
//                print("Detected category: \(firstResult.identifier)")
                completion(image)
                
            }
            
            guard let cgImage = image.cgImage else {
                print("Failed to convert UIImage to CGImage")
                completion(nil)
                return
            }
            
            let contourRequest = VNDetectContoursRequest()
            contourRequest.detectsDarkOnLight = true
            
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try handler.perform([contourRequest])
                    guard let observations = contourRequest.results,
                          let contoursObservation = observations.first else {
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                        return
                    }
                    
                    print("handler contourRequest runned")
                    
                    let size = image.size
                    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
                    guard let context = UIGraphicsGetCurrentContext() else {
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                        return
                    }
                    
                    context.translateBy(x: 0, y: size.height)
                    context.scaleBy(x: 1.0, y: -1.0)
                    context.setLineWidth(2.0)
                    context.setStrokeColor(UIColor.black.cgColor)
                    
                    for contourIndex in 0..<contoursObservation.contourCount {
                        do {
                            let contour = try contoursObservation.contour(at: contourIndex)
                            let path = CGMutablePath()
                            let points = contour.normalizedPoints
                            for (i, point) in points.enumerated() {
                                let normalizedPoint = CGPoint(x: CGFloat(point.x) * size.width, y: CGFloat(point.y) * size.height)
                                if i == 0 {
                                    path.move(to: normalizedPoint)
                                } else {
                                    path.addLine(to: normalizedPoint)
                                }
                            }
                            path.closeSubpath()
                            context.addPath(path)
                        } catch {
                            print("Error getting contour at index \(contourIndex): \(error)")
                        }
                    }
                    
                    context.strokePath()
                    let resultImage = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    
                    DispatchQueue.main.async {
                        completion(resultImage)
                    }
                    
                    // Executar a requisição de classificação
                    try handler.perform([classificationRequest])
                    print("handler runned")
                    
                } catch {
                    print("Error performing vision request: \(error)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
            
        } catch {
            print("Failed to load the model: \(error)")
            completion(nil)
        }
    }
}
