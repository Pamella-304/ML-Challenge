//
//  ContentView.swift
//  ML
//
//  Created by Pamella Alvarenga on 30/07/24.
//

import SwiftUI

struct ScenarioView: View {
    @StateObject private var viewModel = ScenarioViewModel()
    @State private var animalPosition: CGFloat = UIScreen.main.bounds.width * 0.65 // starts at right edge
    @State private var rightEdge: CGFloat = UIScreen.main.bounds.width * 0.65
    @State private var leftEdge: CGFloat = -UIScreen.main.bounds.width * 0.65
    @State private var isFlipped: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            DrawingButtonView()
            
            AnimalView()
                .offset(x: animalPosition)
                .onAppear {
                    startHorizontalAnimation(duration: 3)
                }
                .onChange(of: animalPosition) {
                    isFlipped.toggle()
                }
        }
    }
        
    private func startHorizontalAnimation(duration: Double) {
        Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { timer in
            withAnimation(Animation.linear(duration: duration)) {
                if animalPosition == rightEdge {
                    animalPosition = leftEdge
                } else {
                    animalPosition = rightEdge
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
        Image("tubarao")
            .resizable()
            .frame(width: UIScreen.main.bounds.width * 0.3,
                   height: UIScreen.main.bounds.height * 0.4)
            .scaleEffect(x: isFlipped ? -1 : 1, y: 1)
    }
}
