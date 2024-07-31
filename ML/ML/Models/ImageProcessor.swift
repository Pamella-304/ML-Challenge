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
        
        let request = VNDetectContoursRequest { (request, error) in
            
            if let error = error {
                print("Error in VNDetectContoursRequest: \(error)")
                completion(nil)
                return
            }
            
            
            guard let observations = request.results as? [VNContoursObservation],
                  let contours = observations.first else {
                completion(nil)
                return
            }
            
            let size = image.size
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            guard let context = UIGraphicsGetCurrentContext() else {
                completion(nil)
                return
            }
            
            context.translateBy(x: 0, y: size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.setLineWidth(2.0)
            context.setStrokeColor(UIColor.black.cgColor)
            
            for contourIndex in 0..<contours.contourCount {
                guard let contour = contours.contour(at: contourIndex) else { continue }
                let path = CGMutablePath()
                for i in 0..<contour.pointCount {
                    let point = contour.point(at: i)
                    let normalizedPoint = CGPoint(x: point.x * size.width, y: point.y * size.height)
                    if i == 0 {
                        path.move(to: normalizedPoint)
                    } else {
                        path.addLine(to: normalizedPoint)
                        
                    }
                    path.closeSubpath()
                context.addPath(path)
            }
            
            context.strokePath()
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            completion(resultImage)
            
        }
        
        request.detectsDarkOnLight = true // Configuração opcional para ajustar a detecção
             
             let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
             DispatchQueue.global(qos: .userInitiated).async {
                 do {
                     try handler.perform([request])
                 } catch {
                     print("Error performing vision request: \(error)")
                     completion(nil)
                 }
             }
        
//        guard let cgImage = image.cgImage else {
//            completion(nil)
//            return
//        }
//        let request = VNGenerateObjectnessBasedSaliencyImageRequest { (request, error) in
//            if let error = error {
//                print("Error in VNGenerateObjectnessBasedSaliencyImageRequest: \(error)")
//                completion(nil)
//                return
//            }
//            
//            
//            guard let results = request.results as? [VNPixelBufferObservation],
//                  let pixelBuffer = results.first?.pixelBuffer else {
//                completion(nil)
//                return
//            }
//            
//            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
//            let context = CIContext()
//            if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
//                let resultImage = UIImage(cgImage: cgImage)
//                completion(resultImage)
//            } else {
//                completion(nil)
//            }
//        }
//        
//        
//        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
//        DispatchQueue.global(qos: .userInitiated).async {
//            do {
//                try handler.perform([request])
//            } catch {
//                print("Error performing vision request: \(error)")
//                completion(nil)
//            }
//        }
    }
}
