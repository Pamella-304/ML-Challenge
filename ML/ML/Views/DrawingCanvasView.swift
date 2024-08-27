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
    @StateObject private var scenarioVM = ScenarioViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.undoManager) private var undoManager
    var onAdd: (UIImage) -> Void
    
    var body: some View {
        ZStack{
            MyCanvas(canvasView: $viewModel.canvasView)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Button(action: {
                    viewModel.processDrawing { isolatedImage in
                        if let isolatedImage = isolatedImage {
                            onAdd(isolatedImage)
                        } else {
                            print("failed to process image")
                        }
                        presentationMode.wrappedValue.dismiss() // Fecha a tela modal
                    }
                }) {
                    Text("Add")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Spacer()

            }
            .padding()

        }.onAppear{
            viewModel.setupToolPicker()
        }
    }
}
