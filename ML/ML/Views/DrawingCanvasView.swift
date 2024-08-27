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
    var onAdd: (UIImage?) -> Void
    
    var body: some View {
        ZStack {
            MyCanvas(canvasView: $viewModel.canvasView)
                .edgesIgnoringSafeArea(.all)
            
        }
        .toolbar {
            
            ToolbarItem(placement: .navigationBarLeading) {
                
            }
            
            ToolbarItem(placement: .principal) {
                Text("Draw your sea anima")
                    .font(.headline)
                    .bold()
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button(action: {
                    viewModel.processDrawing { isolatedImage in
                        if let isolatedImage = isolatedImage {
                            onAdd(isolatedImage)
                        } else {
                            //inserir aqui a lógica do popup
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Add drawing")
                        .font(.subheadline)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                }
                
                
                
                
            }

        }
    }
    
}

