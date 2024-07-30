//
//  DrawingCanvasView.swift
//  ML
//
//  Created by Pamella Alvarenga on 30/07/24.
//

import SwiftUI
import PencilKit



struct DrawingCanvasView: View {
    @Environment(\.undoManager) private var undoManager
    @State private var canvasView = PKCanvasView()
    
    
//    private let canvasView: PKCanvasView = {
//        let canvas = PKCanvasView()
//        canvas.drawingPolicy = .anyInput
//        return canvas
//    }()
    
    var body: some View {
        ZStack{
            Color.purple
                .ignoresSafeArea()
            VStack {
                MyCanvas(canvasView: $canvasView)
                    .padding(50)
                
                Button(action: {
                    canvasView.drawing = PKDrawing()
                }) {
                    Text("Clear")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: 400)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                Button(action: {
                    undoManager?.undo()
                }) {
                    Text("Undo")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: 400)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                Button(action: {
                    undoManager?.redo()
                }) {
                    Text("Redo")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: 400)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct MyCanvas: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        return canvasView
    }
    
    func updateUIView(_ canvasView: PKCanvasView, context: Context) { }
}

#Preview {
    DrawingCanvasView()
}
