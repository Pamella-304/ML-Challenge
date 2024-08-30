//
//  ContentView.swift
//  ML
//
//  Created by Pamella Alvarenga on 30/07/24.
//

import SwiftUI

struct ScenarioView: View {
    @StateObject private var scenarioViewModel = ScenarioViewModel()
    @StateObject var drawingCanvasViewModel = DrawingCanvasViewModel()
    @State var moveRight = true
    @State private var isCanvasViewActive = false
    

    let startDate = Date()

    var body: some View {

        NavigationStack{
            ZStack {
                
                NavigationLink(
                    destination: DrawingCanvasView(drawingCanvasViewModel: drawingCanvasViewModel, onAdd: { _ in}),
                    isActive: $isCanvasViewActive
                ) {
                    EmptyView()
                }
                .hidden()
                .transition(.move(edge: .trailing))
                
                BackgroundView()
                ForEach(scenarioViewModel.animals.indices, id: \.self) { index in
                    animatedAnimalView(for: index)
                }
                
                VStack{
                    CutomizedToolBarScenario(isCanvasViewActive: $isCanvasViewActive, viewModel: scenarioViewModel)
                    Spacer()
                }
                
            }

        }
    }
    
    @ViewBuilder
    private func animatedAnimalView(for index: Int) -> some View {
        let animal = scenarioViewModel.animals[index]
        
        switch(animal.animationType) {
        case .horizontal:
            let randomY = Double.random(in: 300...900)
            SwimAnimationView(
                uiImage: scenarioViewModel.isolatedImages[index], randomHeight: randomY
            )
            
        case .shake:
            let randomY = Double.random(in: 300...500)
            let randomX = Double.random(in: 100...1500)
            ShakeAnimationView(
                uiImage: scenarioViewModel.isolatedImages[index], randomHeight: randomY,
                randomWidth: randomX
            )
            
        case .wave:
            let randomY = Double.random(in: 500...900)
            let randomX = Double.random(in: 100...1500)
            WaveAnimationView(
                uiImage: scenarioViewModel.isolatedImages[index],
                randomHeight: randomY,
                randomWidth: randomX
            )
        }
    }

    

}



#Preview {
    ScenarioView()
}
