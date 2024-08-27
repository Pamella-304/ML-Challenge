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
                Spacer()
                Button(action: {
                    viewModel.processDrawing { isolatedImage in
                        if let isolatedImage = isolatedImage {
                            onAdd(isolatedImage)
                            if !viewModel.showAlert {
                                presentationMode.wrappedValue.dismiss()
                            }
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
            .padding()

        }.onAppear{
            viewModel.setupToolPicker()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Unrecognized Drawing"),
                  message: Text("Your drawing is creative, but we couldn't understand it. Try adding more details or redoing it."),
                  dismissButton: .default(Text("OK")))
        }
    }
}
