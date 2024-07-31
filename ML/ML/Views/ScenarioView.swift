//
//  ContentView.swift
//  ML
//
//  Created by Pamella Alvarenga on 30/07/24.
//

import SwiftUI

import SwiftUI

struct ScenarioView: View {
    @StateObject private var viewModel = ScenarioViewModel()
    
    var body: some View {
        ZStack {
            BackgroundView()
            DrawingButtonView()
        }
    }
    
    private func BackgroundView() -> some View {
        Image("aquario")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
    }
    
    private func DrawingButtonView() -> some View {
        VStack {
            Button(action: {
                viewModel.toggleDrawingCanvas()
            }) {
                Image(systemName: "pencil")
                    .imageScale(.large)
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
            }.sheet(isPresented: $viewModel.showDrawingCanvas) {
                DrawingCanvasView()
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ScenarioView()
}
