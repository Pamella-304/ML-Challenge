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
    @State private var navigationLinkIsActive: Bool = false

    
    var body: some View {
        
        NavigationStack{
            ZStack {
                BackgroundView()
                
                animatedAnimalView(initialX: viewModel.animalX,
                                   initialY: viewModel.animalY,
                                   animationType: .wave)
            }
            .navigationBarTitle("My Sea World", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    navigationLinkIsActive = true
                    NavigationLink("",destination: DrawingCanvasView(viewModel: DrawingCanvasViewModel(), onAdd: { _ in }),isActive: $navigationLinkIsActive)
                    
                }) {
                    Text("New Drawing")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 32)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            )
            
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
    
    private func AnimalView() -> some View {
        ForEach(viewModel.isolatedImages, id: \.self) { image in
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.3)
                .scaleEffect(x: viewModel.isFlipped ? -1 : 1, y: 1)
        }
    }
}
