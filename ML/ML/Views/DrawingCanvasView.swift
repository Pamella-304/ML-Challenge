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
            VStack{
                
                CutomizedToolBarCanvas(onAdd: onAdd, viewModel: viewModel)
                
                Spacer()
                
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            viewModel.setupToolPicker()
        }
        
        
    }
    
    
}

