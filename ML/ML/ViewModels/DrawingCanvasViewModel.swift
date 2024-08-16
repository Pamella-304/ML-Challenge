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
    @Published var croppedImage: UIImage?
    @Published var currentDrawing: UIImage?
    @Published var canvasView: PKCanvasView
    var toolPicker: PKToolPicker
    
    private var imageProcessor: ImageProcessor // instanciando a classe que trata da conversao necessaria para transformar o conteudo desenhado no canvas em um objeto animável e apresentável em outra view
    
    init() {
        self.canvasView = PKCanvasView()
        self.imageProcessor = ImageProcessor()
        self.toolPicker = PKToolPicker()

    }
    
    
    func setupToolPicker() {
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
        
    }
    
    @MainActor
    func processDrawing(completion: @escaping (UIImage?) -> Void) {
        
        self.canvasView.layoutIfNeeded()
        
        guard !self.canvasView.bounds.isEmpty else {
            print("Canvas bounds are empty")
            self.isolatedImage = nil
            completion(nil)
            return
        }
        let drawingImage = self.canvasView.drawing.image(from: self.canvasView.bounds, scale: UIScreen.main.scale)
        self.currentDrawing = drawingImage
                
        if let currentDrawing = self.currentDrawing {
            
            self.imageProcessor.isolateDrawing(from: currentDrawing) { [weak self] isolatedImage in
                guard let self = self else { return }
                
                if let isolatedImage = isolatedImage, let croppedImage = self.cropToContent(isolatedImage) {
                    DispatchQueue.main.async {
                        self.croppedImage = croppedImage
                        completion(croppedImage)
                    }
                } else {
                    completion(nil)
                }
                
            }
            
            
        } else {
            completion(nil)
        }
    }
    
    func resetCanvas() {
        self.canvasView.drawing = PKDrawing()
        self.currentDrawing = nil
        self.isolatedImage = nil
    }
    
    
    func cropToContent(_ image: UIImage) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
        
        guard let context = CGContext(data: nil,
                                      width: cgImage.width,
                                      height: cgImage.height,
                                      bitsPerComponent: cgImage.bitsPerComponent,
                                      bytesPerRow: cgImage.bytesPerRow,
                                      space: cgImage.colorSpace!,
                                      bitmapInfo: bitmapInfo)
        else { return nil }
        
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: cgImage.width, height: cgImage.height))
        
        guard let pixelBuffer = context.data else { return nil }
        
        let data = pixelBuffer.bindMemory(to: UInt8.self, capacity: width * height * bytesPerPixel)
        
        var minY = cgImage.height
        var maxY: Int = 0
        var minX = cgImage.width
        var maxX: Int = 0
        
        for y in 0..<cgImage.height {
            for x in 0..<cgImage.width {
                let pixelIndex = (y * bytesPerRow) + (x * bytesPerPixel)
                let alpha = data[pixelIndex + 3] // Índice do canal alfa
                if alpha != 0 {
                    if y < minY { minY = y }
                    if y > maxY { maxY = y }
                    if x < minX { minX = x }
                    if x > maxX { maxX = x }
                }
            }
        }
        
        if minX > maxX || minY > maxY {
            return nil
        }
        
        let cropRect = CGRect(x: minX, y: minY, width: maxX - minX + 1, height: maxY - minY + 1)
        guard let croppedCgImage = cgImage.cropping(to: cropRect) else { return nil }
        
        return UIImage(cgImage: croppedCgImage)
        
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

