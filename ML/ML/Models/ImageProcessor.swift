//
//  ImageProcessor.swift
//  ML
//
//  Created by Pamella Alvarenga on 31/07/24.

import UIKit
import Vision
import CoreML

class ImageProcessor {
    typealias ImageHandler = ((UIImage?) -> (Void))
    var context: CGContext?
    var resultImage: UIImage?
    var resultCategory: String?

    func isolateDrawing(from image: UIImage, completion: @escaping (UIImage?) -> Void) {
        do {
            guard let imageWithBackground = getImageWithBackground(image) else {
                completion(nil)
                return
            }

            let normalizedImage = resizeImage(imageWithBackground, targetSize: CGSize(width: 224, height: 224))
            
            guard let classificationRequest = createClassificationRequest(image: normalizedImage, handler: { response in
                completion(response)
            }) else { return }

            guard let cgImage = getCGImage(image: normalizedImage, handler: { response in
                completion(response)
            }) else { return }

            let contourRequest = createContourRequest()
            let size = image.size
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
    
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try handler.perform([classificationRequest])
                    
                    self.createContext(size: size, handler: { response in
                        completion(response)
                    })

                    guard let contoursObservation = try self.performContourRequest(image: image, contour: contourRequest, handler: handler, completion: {
                        response in completion(response)
                    }) else { return }

                    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

                    self.getPath(contoursObservation: contoursObservation, size: size)

                    self.updateResultImage() { response in
                        completion(response)
                    }
                    
                } catch {
                    self.performError(message: "Error performing vision request:", error: error) { response in
                        completion(response)
                    }
                }
            }
        }
    }

    func getImageWithBackground(_ image: UIImage) -> UIImage? {
        let size = image.size
        let rect = CGRect(origin: .zero, size: size)

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let newContext = UIGraphicsGetCurrentContext() else { return nil }

        newContext.setFillColor(UIColor.white.cgColor)
        newContext.fill(rect)

        image.draw(in: rect)

        let imageWithBackground = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return imageWithBackground
    }
    
    func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        let newSize = CGSize(width: size.width * widthRatio, height: size.height * heightRatio)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

    private func updateResultImage(completion: @escaping ImageHandler) {
        self.resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        DispatchQueue.main.async {
            completion(self.resultImage)
        }
    }

    private func getPath(contoursObservation: VNContoursObservation, size: CGSize) {
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
                context?.addPath(path)
                context?.strokePath()
            } catch {
                print("Error getting contour at index \(contourIndex): \(error)")
            }
        }
    }

    private func createContext(size: CGSize, handler: @escaping ImageHandler) {
        guard let context = UIGraphicsGetCurrentContext() else {
            DispatchQueue.main.async {
                handler(nil)
            }
            return
        }
        
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.black.cgColor)
    }
    
    private func performContourRequest(image: UIImage, contour: VNDetectContoursRequest, handler: VNImageRequestHandler, completion: @escaping ImageHandler) throws -> VNContoursObservation? {
        try handler.perform([contour])

        guard let observations = contour.results,
              let contoursObservation = observations.first else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return nil
        }
        
        return contoursObservation
    }

    private func createContourRequest() -> VNDetectContoursRequest {
        let contourRequest = VNDetectContoursRequest()
        contourRequest.detectsDarkOnLight = true
        return contourRequest
    }

    private func createClassificationRequest(image: UIImage, handler: @escaping ImageHandler) -> VNCoreMLRequest? {
        do {
            let config = MLModelConfiguration()
            let model = try AnimalClassifier(configuration: config)
            let visionModel = try VNCoreMLModel(for: model.model)
            
            let classificationRequest = VNCoreMLRequest(model: visionModel) { (request, error) in
                if let error = error {
                    print("Error in VNCoreMLRequest: \(error)")
                    handler(nil)
                    return
                }
                
                guard let results = request.results as? [VNClassificationObservation],
                      let firstResult = results.first else {
                    print("Failed to classify the image")
                    handler(nil)
                    return
                }
                
                print("Detected category: \(firstResult.identifier)")
                self.resultCategory = firstResult.identifier
                handler(image)
            }
            
            return classificationRequest
            
        } catch {
            performError(message: "Failed to load the model:", error: error) { response in
                handler(response)
            }
        }
        
        return nil
    }

    private func getCGImage(image: UIImage, handler: @escaping ImageHandler) -> CGImage? {
        guard let cgImage = image.cgImage else {
            print("Failed to convert UIImage to CGImage")
            handler(nil)
            return nil
        }
        return cgImage
    }

    private func performError(message: String, error: Error?, handler: @escaping ((UIImage?) -> Void)) {
        if let error = error { print(message + " \(error)") }
        DispatchQueue.main.async {
            handler(nil)
        }
    }
}
