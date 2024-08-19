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
            
            if viewModel.animalName != nil {
                animatedAnimalView()
            }

            DrawingButtonView()
        }
        .onAppear {
            viewModel.animalName = "fish"
            if let animalName = viewModel.animalName, let selectedAnimal = animals[animalName] {
                viewModel.setAnimal(selectedAnimal)
            }
        }
    }
    
    @ViewBuilder
    private func animatedAnimalView() -> some View {
        AnimalView(animalImage: viewModel.animalImage)
            .offset(x: viewModel.animalPositionX, y: viewModel.animalPositionY)
            .rotationEffect(.degrees({
                switch viewModel.animationType {
                case .wave:
                    return viewModel.rotationAngle
                case .shake:
                    return viewModel.shake ? 1 : -1
                default:
                    return 0
                }
            }()))
            .onAppear {
                switch viewModel.animationType {
                case .horizontal:
                    viewModel.startHorizontalAnimation()
                case .wave:
                    viewModel.startRotationAnimation()
                    viewModel.startWaveAnimation()
                case .shake:
                    viewModel.startShakeAnimation()
                }
            }
            .onChange(of: viewModel.animalPositionX) {
                if case .horizontal = viewModel.animationType {
                    viewModel.isFlipped.toggle()
                } else if case .wave = viewModel.animationType {
                    viewModel.isFlipped.toggle()
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
                DrawingCanvasView(viewModel: canvasVM) { image in
                    viewModel.addImage(image)
                }
            }
            .padding()
            Spacer()
        }
        .padding()
    }
    
    private func AnimalView(animalImage: UIImage) -> some View {
        ForEach(viewModel.isolatedImages, id: \.self) { image in
            Image(uiImage: animalImage)
            //Image("tubarao") // used for tests
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.2,
                       height: UIScreen.main.bounds.height * 0.3)
                .scaleEffect(x: viewModel.isFlipped ? -1 : 1, y: 1)
        }
    }
}
