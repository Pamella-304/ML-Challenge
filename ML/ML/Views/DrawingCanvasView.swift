//
//  DrawingCanvasView.swift
//  ML
//
//  Created by Pamella Alvarenga on 30/07/24.
//

import SwiftUI
import PencilKit

struct DrawingCanvasView: View {
    
    @ObservedObject var viewModel: DrawingCanvasViewModel
    @Environment(\.undoManager) private var undoManager
    var onAdd: (UIImage) -> Void

    
    var body: some View {
        ZStack{
            Color.purple
                .ignoresSafeArea()
            VStack {
                MyCanvas(canvasView: $viewModel.canvasView)
                    .padding(50)
                
                Button(action: {
                    viewModel.canvasView.drawing = PKDrawing()
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
                
                Button(action: {
                    print("action initiated")
                    viewModel.processDrawing { image in
                        if let image = image {
                            print("processed image: \(image)")
                            onAdd(image)
                            print("Image gotten")
                        } else {
                            print("failed to process image")
                        }
                    }
                }) {
                    Text("Add")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
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
        canvasView.becomeFirstResponder()

        return canvasView
    }
    
    func updateUIView(_ canvasView: PKCanvasView, context: Context) { }
}


#Preview {
    DrawingCanvasView(viewModel: DrawingCanvasViewModel(), onAdd:  { _ in })
}
