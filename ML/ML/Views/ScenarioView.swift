//
//  ContentView.swift
//  ML
//
//  Created by Pamella Alvarenga on 30/07/24.
//

import SwiftUI

struct ScenarioView: View {
    @StateObject private var viewModel = ScenarioViewModel()
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            AnimalView()
                .offset(x: viewModel.animalX, y: viewModel.animalY)
                .onAppear {
                    viewModel.startHorizontalAnimation(duration: 3)
                }
                .onChange(of: viewModel.animalX) {
                    viewModel.isFlipped.toggle()
                }
            
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
                DrawingCanvasView(viewModel: DrawingCanvasViewModel()) { image in
                    viewModel.addImage(image)
                }
            }

            Spacer()
        }
        .padding()
    }

    private func AnimalView() -> some View {
        ForEach(viewModel.isolatedImages, id: \.self) { image in
            //Image(uiImage: image)
            Image("tubarao") // used for tests
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.3,
                       height: UIScreen.main.bounds.height * 0.4)
                .scaleEffect(x: viewModel.isFlipped ? -1 : 1, y: 1)
        }
    }
}
