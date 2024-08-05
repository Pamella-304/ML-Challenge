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
            
            GeometryReader {geometry in
                ForEach(viewModel.isolatedImages, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 500, height: 500)
                        .position(x: geometry.size.width/2 - 50, y: geometry.size.height/2 - 50)
                }
            }
            
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
                    }
                    
                }
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    ScenarioView()
}
