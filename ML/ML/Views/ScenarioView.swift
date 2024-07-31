//
//  ContentView.swift
//  ML
//
//  Created by Pamella Alvarenga on 30/07/24.
//

import SwiftUI

struct ScenarioView: View {
    @StateObject private var viewModel = ScenarioViewModel()
    @State private var animalPosition: CGFloat = UIScreen.main.bounds.width - 800 // starts at right edge
    @State private var leftEdge: CGFloat = -UIScreen.main.bounds.width + 800
    
    var body: some View {
        ZStack {
            BackgroundView()
            DrawingButtonView()
            
            AnimalView()
                .offset(x: animalPosition)
                .onAppear {
                    withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: true)) {
                        animalPosition = leftEdge
                    }
                }
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
    
    private func AnimalView() -> some View {
        Circle()
            .foregroundStyle(.red)
            .frame(width: 100, height: 100)
    }
}
