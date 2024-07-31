//
//  ContentView.swift
//  ML
//
//  Created by Pamella Alvarenga on 30/07/24.
//

import SwiftUI

struct ScenarioView: View {
    
    @StateObject private var viewModel = ScenarioViewModel()
    @State private var showDrawingCanvas = false
    
    var body: some View {
            ZStack {
                Image("aquario")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    
                    Button(action: {
                        showDrawingCanvas.toggle()
                    }) {
                        Image(systemName: "pencil")
                            .imageScale(.large)
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                    }.sheet(isPresented: $showDrawingCanvas) {
                        DrawingCanvasView(viewModel: DrawingCanvasViewModel()) { image in
                            viewModel.addImage(image)
                            showDrawingCanvas = false
                        }
                        
                        ForEach(viewModel.isolatedImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 100)
                                .transition(.scale)
                        }
                    }
                }
            }
    }
}

#Preview {
    ScenarioView()
}
