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
    // private(set) var canvasView = PKCanvasView()
    
    init() {
        self.canvasView = PKCanvasView()
        self.imageProcessor = ImageProcessor()
    }
    
    func processDrawing(completion: @escaping (UIImage?) -> Void) {
        let currentDrawing = canvasView.drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
        
        print("currentDrawing")
        print(currentDrawing)
        
        imageProcessor.isolateDrawing(from: currentDrawing) { [weak self] isolatedImage in
            DispatchQueue.main.async {
                self?.isolatedImage = isolatedImage
                completion(isolatedImage)
            }
        }
        
        
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

