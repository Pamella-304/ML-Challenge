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
            
            ForEach(viewModel.animals.indices, id: \.self) { index in
                animatedAnimalView(for: index)
            }

            DrawingButtonView()
        }
        .onAppear {
            viewModel.addAnimal(animals["fish"]!)
            viewModel.addAnimal(animals["fish"]!)
            viewModel.addAnimal(animals["fish"]!)
            viewModel.addAnimal(animals["fish"]!)
            viewModel.addAnimal(animals["shark"]!)
            viewModel.addAnimal(animals["starfish"]!)
        }
    }
    
    @ViewBuilder
    private func animatedAnimalView(for index: Int) -> some View {
        var animal = viewModel.animals[index]
        
        Image(uiImage: animal.image)
            .resizable()
            .frame(width: UIScreen.main.bounds.width * 0.2,
                   height: UIScreen.main.bounds.height * 0.3)
            .scaleEffect(x: animal.isFlipped ? -1 : 1, y: 1)
            .offset(x: animal.positionX, y: animal.positionY)
            .rotationEffect(.degrees({
                switch animal.animationType {
                case .wave:
                    return animal.rotationAngle
                case .shake:
                    return animal.shake ? 1 : -1
                default:
                    return 0
                }
            }()))
            .onAppear {
                switch animal.animationType {
                case .horizontal:
                    viewModel.startHorizontalAnimation(for: index)
                case .wave:
                    viewModel.startRotationAnimation(for: index)
                    viewModel.startWaveAnimation(for: index)
                case .shake:
                    viewModel.startShakeAnimation(for: index)
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
}
