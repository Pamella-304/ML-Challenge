//
//  ScenarioViewModel.swift
//  ML
//
//  Created by Pamella Alvarenga on 31/07/24.
//

import SwiftUI

enum AnimationType {
    case horizontal(duration: Double)
    case wave(duration: Double)
    case shake
}

class ScenarioViewModel: ObservableObject {
    // Animation Helpers
    @Published var rotationAngle: Double = 0
    let angles: [Double] = [0, 5, 10, 15, 20, 25]
    @Published var isFlipped: Bool = false
    @Published var shake: Bool = false
    
    // Canvas Helpers
    @Published var showDrawingCanvas = false
    @Published var isolatedImages: [UIImage] = []
    
    func startHorizontalAnimation(duration: Double) {
        Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { timer in
            withAnimation(Animation.linear(duration: duration)) {
                if self.animalX == Positions.rightEdge {
                    self.animalX = Positions.leftEdge
                } else {
                    self.animalX = Positions.rightEdge
                }
            }
        }
    }
    
    func startWaveAnimation(duration: Double) {
        Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { timer in
            withAnimation(Animation.linear(duration: duration)) {
                if self.animalX == Positions.rightEdge {
                    self.animalX = Positions.leftEdge
                } else {
                    self.animalX = Positions.rightEdge
                }
            }
        }
    }
    
    func startShakeAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.05).repeatForever(autoreverses: true)) {
            self.shake.toggle()
        }
    }
    
    func startRotationAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { timer in
            withAnimation {
                self.rotationAngle = self.angles.randomElement() ?? 0
            }
        }
    }
    
    func toggleDrawingCanvas() {
        showDrawingCanvas.toggle()
    }
    
    func addImage(_ image: UIImage) {
        isolatedImages.append(image)
    }
}
