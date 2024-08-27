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
    
    let startDate = Date()
    
    var body: some View {
        ZStack {
            BackgroundView()
            ForEach(viewModel.animals.indices, id: \.self) { index in
                animatedAnimalView(for: index)
            }.padding()
            DrawingButtonView().padding()
        }
    }
    
    @ViewBuilder
    private func animatedAnimalView(for index: Int) -> some View {
        let animal = viewModel.animals[index]
        
        TimelineView (.animation) { tl in
            let time = startDate.distance(to: tl.date)
            
            switch(animal.animationType) {
            case .horizontal:
                Image(uiImage: viewModel.isolatedImages[index])
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.3)
                    .starAnimation(time: Float(time), size: Float(UIScreen.main.bounds.height * 0.3))
                
            case .shake:
                Image(uiImage: viewModel.isolatedImages[index])
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.3)
                    .starAnimation(time: Float(time), size: Float(UIScreen.main.bounds.height * 0.3))
                
            case .wave:
                Image(uiImage: viewModel.isolatedImages[index])
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.3)
                    .starAnimation(time: Float(time), size: Float(UIScreen.main.bounds.height * 0.3))
            }
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
                    viewModel.addImage(image)
                    
                    if let category = canvasVM.resultCategory,
                       let animal = animals[category] {
                        viewModel.addAnimal(animal)
                    }
                }
            }
            Spacer()
        }.padding()
    }
}


extension View {
    func starAnimation(time: Float, size: Float) -> some View {
        self
            .distortionEffect(ShaderLibrary.compress(.float(time)), maxSampleOffset: .zero)
            .distortionEffect(ShaderLibrary.horizontal(.float(time), .float(300)), maxSampleOffset: .zero)
        
    }
    
    func waveAnimation(time: Float) -> some View {
        self.distortionEffect(ShaderLibrary.rotate(.float(time)), maxSampleOffset: .zero)
    }
}

#Preview {
    ScenarioView()
}
