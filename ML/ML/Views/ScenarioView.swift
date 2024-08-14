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
            
            animatedAnimalView(initialX: viewModel.animalX,
                               initialY: viewModel.animalY,
                               animationType: .shake)

            DrawingButtonView()
        }
    }
    
    @ViewBuilder
    private func animatedAnimalView(initialX: CGFloat, initialY: CGFloat, animationType: AnimationType) -> some View {
        AnimalView()
            .offset(x: viewModel.animalX, y: viewModel.animalY)
            .rotationEffect(.degrees({
                switch animationType {
                case .wave:
                    return viewModel.rotationAngle
                case .shake:
                    return viewModel.shake ? 4 : -4
                default:
                    return 0
                }
            }()))
            .onAppear {
                switch animationType {
                case .horizontal:
                    viewModel.startHorizontalAnimation()
                case .wave:
                    viewModel.startRotationAnimation()
                    viewModel.startWaveAnimation()
                case .shake:
                    viewModel.startShakeAnimation()
                }
            }
            .onChange(of: viewModel.animalX) {
                if case .horizontal = animationType {
                    viewModel.isFlipped.toggle()
                } else if case .wave = animationType {
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
