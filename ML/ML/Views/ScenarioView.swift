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
    @State private var isCanvasViewActive = false

    
    
    var body: some View {
        NavigationStack{
            ZStack {
                BackgroundView()
                ForEach(viewModel.animals.indices, id: \.self) { index in
                    animatedAnimalView(for: index)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        //
                    } label: {
                        Label(
                            "More",
                            systemImage: "ellipsis.circle"
                        )
                    }.padding()
                }
                
                ToolbarItem(placement: .principal) {
                    Text("My Magic Sea")
                        .font(.headline)
                        .bold()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isCanvasViewActive = true
                    }) {
                        Text("Abrir Canvas")
                    }
                }
                
            }.background(
                NavigationLink(
                    destination: DrawingCanvasView(viewModel: DrawingCanvasViewModel(), onAdd: { _ in}),
                    isActive: $isCanvasViewActive
                ) {
                    EmptyView()
                }
            )
        }
    }
    
    @ViewBuilder
    private func animatedAnimalView(for index: Int) -> some View {
        let animal = viewModel.animals[index]
        
        Image(uiImage: viewModel.isolatedImages[index])
            .resizable()
            .frame(width: UIScreen.main.bounds.width * 0.2,
                   height: UIScreen.main.bounds.height * 0.3)
            .scaleEffect(x: scaleEffectX(for: animal), y: 1)
            .offset(x: animal.positionX, y: animal.positionY)
            .rotationEffect(rotationAngle(for: animal))
            .onAppear {
                handleAnimation(for: index)
            }
    }

    private func scaleEffectX(for animal: Animal) -> CGFloat {
        animal.isFlipped ? -1 : 1
    }

    private func rotationAngle(for animal: Animal) -> Angle {
        switch animal.animationType {
        case .wave:
            return .degrees(animal.rotationAngle)
        case .shake:
            return .degrees(animal.shake ? 1 : -1)
        default:
            return .degrees(0)
        }
    }

    private func handleAnimation(for index: Int) {
        let animal = viewModel.animals[index]
        
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
