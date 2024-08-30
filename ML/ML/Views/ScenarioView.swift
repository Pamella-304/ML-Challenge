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
    @State var moveRight = true
    @State private var isCanvasViewActive = false

    let startDate = Date()

    var body: some View {
        ZStack {
            BackgroundView()
            ForEach(viewModel.animals.indices, id: \.self) { index in
                animatedAnimalView(for: index)
            }.padding()
                .padding()
            
            DrawingButtonView()
                .padding()
        }
    }
    
    @ViewBuilder
    private func animatedAnimalView(for index: Int) -> some View {
        let animal = viewModel.animals[index]
        
        switch(animal.animationType) {
        case .horizontal:
            let randomY = Double.random(in: 300...900)
            SwimAnimationView(
                uiImage: viewModel.isolatedImages[index], randomHeight: randomY
            )
            
        case .shake:
            let randomY = Double.random(in: 300...500)
            let randomX = Double.random(in: 100...1500)
            ShakeAnimationView(
                uiImage: viewModel.isolatedImages[index], randomHeight: randomY,
                randomWidth: randomX
            )
            
        case .wave:
            let randomY = Double.random(in: 500...900)
            let randomX = Double.random(in: 100...1500)
            WaveAnimationView(
                uiImage: viewModel.isolatedImages[index],
                randomHeight: randomY,
                randomWidth: randomX
            )
        }
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

            }
            .fullScreenCover(isPresented: $viewModel.showDrawingCanvas) {
                DrawingCanvasView(viewModel: canvasVM) { image in
                    if let category = canvasVM.resultCategory {
                        if category == "None" {
                            canvasVM.showAlert = true
                            return
                        }

                        viewModel.addImage(image)
                        
                        if let animal = createAnimal(for: category) {
                            viewModel.addAnimal(animal)
                        }
                    }
                }
            }
            Spacer()
        }.padding()
    }
    
}

#Preview {
    ScenarioView()
}
