//
//  DrawingCanvasViewModel.swift
//  ML
//
//  Created by Pamella Alvarenga on 31/07/24.
//

import SwiftUI
import PencilKit
import CoreML
import Vision

class DrawingCanvasViewModel: ObservableObject {
    @Published var isolatedImage: UIImage?
    @Published var currentDrawing: UIImage?
    @Published var canvasView: PKCanvasView
    
    private var imageProcessor: ImageProcessor // instanciando a classe que trata da conversao necessaria para transformar o conteudo desenhado no canvas em um objeto animável e apresentável em outra view
    
    init() {
        self.canvasView = PKCanvasView()
        self.imageProcessor = ImageProcessor()
        
    }
    
    @MainActor
    func processDrawing(completion: @escaping (UIImage?) -> Void) {
                
            self.canvasView.layoutIfNeeded()
            
            print("dimensoes do canvas")
            print(self.canvasView.bounds)
            
            guard !self.canvasView.bounds.isEmpty else {
                print("Canvas bounds are empty")
                self.isolatedImage = nil
                completion(nil)
                return
            }
            let drawingImage = self.canvasView.drawing.image(from: self.canvasView.bounds, scale: UIScreen.main.scale)
            self.currentDrawing = drawingImage
            
            print("currentDrawing")
            print(self.currentDrawing!)
            
            if let currentDrawing = self.currentDrawing {
                
                self.imageProcessor.isolateDrawing(from: currentDrawing) { [weak self] isolatedImage in
                    
                    DispatchQueue.main.async {
                        self?.isolatedImage = isolatedImage
                        completion(isolatedImage)
                    }
                        
                }
                
            } else {
                    print("Failed to process drawing")
                    completion(nil)
                }
        }
        
    func resetCanvas() {
        self.canvasView.drawing = PKDrawing()
        self.currentDrawing = nil
        self.isolatedImage = nil
    }
}

extension PKCanvasView {
    func getImage() -> UIImage? {
        let image = UIImage(view: self)
        
        return image
    }
}

extension UIImage {
    convenience init?(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

