//
//  ImageProcessor.swift
//  ML
//
//  Created by Pamella Alvarenga on 31/07/24.
//

import Foundation
import Vision
import UIKit

//classe que trata da conversao necessaria para transformar o conteudo desenhado no canvas em um objeto animável e apresentável em outra view

class ImageProcessor {
    func isolateDrawing(from image: UIImage, completion: @escaping (UIImage?) -> Void) {
        guard let cgImage = image.cgImage else {
            completion(nil)
            return
        }
        
        let request = VNDetectContoursRequest()
        request.detectsDarkOnLight = true // Configuração opcional para ajustar a detecção

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
                
                guard let observations = request.results as? [VNContoursObservation],
                      let contoursObservation = observations.first else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
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
                
            } catch {
                print("Error performing vision request: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
