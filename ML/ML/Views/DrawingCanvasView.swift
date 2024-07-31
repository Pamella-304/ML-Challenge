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
    @State private var toolPicker = PKToolPicker()
    @Environment(\.presentationMode) var presentationMode // Para fechar a view

    
    var body: some View {
        ZStack{
            Color.purple
                .ignoresSafeArea()
            VStack {
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Fecha o DrawingCanvasView
                }) {
                    Text("Close")
                        .font(.title2)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                MyCanvas(canvasView: $canvasView, toolPicker: $toolPicker)
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
    @Binding var toolPicker: PKToolPicker
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()

        return canvasView
    }
    
    func updateUIView(_ canvasView: PKCanvasView, context: Context) { }
}



#Preview {
    DrawingCanvasView()
}
