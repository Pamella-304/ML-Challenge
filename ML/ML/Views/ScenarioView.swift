//
//  ContentView.swift
//  ML
//
//  Created by Pamella Alvarenga on 30/07/24.
//

import SwiftUI

struct ScenarioView: View {
    @StateObject private var viewModel = ScenarioViewModel()
    @StateObject var canvasVM = DrawingCanvasViewModel()
    
    var body: some View {
        ZStack {
            BackgroundView()
            AnimalView()
                .offset(x: viewModel.animalPosition)
                .onAppear {
                    viewModel.startHorizontalAnimation(duration: 3)
                }
                .onChange(of: viewModel.animalPosition) {
                    viewModel.isFlipped.toggle()
                    
                    GeometryReader {geometry in
                        ForEach(viewModel.isolatedImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 500, height: 500)
                                .position(x: geometry.size.width/2 - 50, y: geometry.size.height/2 - 50)
                            
                        }
                    }
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
                DrawingCanvasView(viewModel: canvasVM) { image in
                    viewModel.addImage(image)
                }
            }
            .padding()
            Spacer()
        }
        .padding()
    }
    
    private func AnimalView() -> some View {
        ForEach(viewModel.isolatedImages, id: \.self) { image in
            Image(uiImage: image)
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.3,
                       height: UIScreen.main.bounds.height * 0.4)
                .scaleEffect(x: viewModel.isFlipped ? -1 : 1, y: 1)
        }
    }
}
