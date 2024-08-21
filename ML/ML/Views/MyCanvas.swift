//
//  MyCanvas.swift
//  ML
//
//  Created by Pamella Alvarenga on 16/08/24.
//

import PencilKit
import SwiftUI

struct MyCanvas: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.becomeFirstResponder()
   

        return canvasView
    }
    
    func updateUIView(_ canvasView: PKCanvasView, context: Context) {
        
    }
}
