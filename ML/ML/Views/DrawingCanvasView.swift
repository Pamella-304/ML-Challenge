//
//  DrawingCanvasView.swift
//  ML
//
//  Created by Pamella Alvarenga on 30/07/24.
//

import SwiftUI
import PencilKit

struct DrawingCanvasView: View {
    @ObservedObject var drawingCanvasViewModel: DrawingCanvasViewModel
    @ObservedObject var scenarioViewModel = ScenarioViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.undoManager) private var undoManager
    
    
    var body: some View {
        ZStack {
            
            MyCanvas(canvasView: $drawingCanvasViewModel.canvasView)
                .edgesIgnoringSafeArea(.all)
            VStack{
                
                CutomizedToolBarCanvas(onAdd: onAdd, drawingCanvasViewModel: drawingCanvasViewModel, scenarioViewModel: scenarioViewModel)
                
                Spacer()
                
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .onAppear{
            drawingCanvasViewModel.setupToolPicker()
        }
        
        
    }
    
    
}

