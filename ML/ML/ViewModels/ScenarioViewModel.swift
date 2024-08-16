//
//  ScenarioViewModel.swift
//  ML
//
//  Created by Pamella Alvarenga on 31/07/24.
//

import SwiftUI

enum AnimationType {
    case horizontal
    case wave
    case shake
}

class ScenarioViewModel: ObservableObject {
    // Positions
    @Published var animalX: CGFloat = UIScreen.main.bounds.width * 0.65 // starts at right edge
    @Published var animalY: CGFloat = -UIScreen.main.bounds.height * 0 // starts at middle
    @Published var horizontalMiddle: CGFloat = UIScreen.main.bounds.width * 0
    @Published var rightEdge: CGFloat = UIScreen.main.bounds.width * 0.65
    @Published var leftEdge: CGFloat = -UIScreen.main.bounds.width * 0.65
    @Published var verticalMiddle: CGFloat = UIScreen.main.bounds.height * 0
    @Published var bottomEdge: CGFloat = UIScreen.main.bounds.height * 0.4
    @Published var topEdge: CGFloat = -UIScreen.main.bounds.height * 0.4
    
    // Animation Helpers
    @Published var rotationAngle: Double = 0
    let angles: [Double] = [0, 5, 10, 15, 20, 25]
    @Published var isFlipped: Bool = false
    @Published var shake: Bool = false
    
    // Canvas Helpers
    @Published var showDrawingCanvas = false
    @Published var isolatedImages: [UIImage] = []
    
    func startHorizontalAnimation() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { timer in
            withAnimation(Animation.linear(duration: 3.0)) {
                if self.animalX == self.rightEdge {
                    self.animalX = self.leftEdge
                } else {
                    self.animalX = self.rightEdge
                }
            }
        }
    }
    
    func startWaveAnimation() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { timer in
            withAnimation(Animation.linear(duration: 3.0)) {
                if self.animalX == self.rightEdge {
                    self.animalX = self.leftEdge
                } else {
                    self.animalX = self.rightEdge
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
        DispatchQueue.main.async {
            self.isolatedImages.append(image)
        }
    }
    
}
