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
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.undoManager) private var undoManager
    var onAdd: (UIImage?) -> Void
    
    init(viewModel: DrawingCanvasViewModel, onAdd: @escaping (UIImage?) -> Void) {
        self.viewModel = viewModel
        self.onAdd = onAdd
        setupToolPicker()
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                MyCanvas(canvasView: $viewModel.canvasView)
                    .edgesIgnoringSafeArea(.all)
                
            }.navigationBarTitle("Draw your sea animal", displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .imageScale(.large)
                            Text("Back")
                        }
                    },
                    trailing: Button(action: {
                        viewModel.processDrawing { image in
                            if let image = image {
                                onAdd(image)
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }) {
                        Text("Add Drawing")
                            .padding(.vertical, 8)
                            .padding(.horizontal, 32)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                )
            
        }
    }
    
    private func setupToolPicker() {
           viewModel.setupToolPicker()
       }
    
}


#Preview {
    DrawingCanvasView(viewModel: DrawingCanvasViewModel(), onAdd:  { _ in })
}
