//
//  ScenarioViewModel.swift
//  ML
//
//  Created by Pamella Alvarenga on 31/07/24.
//

import SwiftUI

struct Positions {
    static let horizontalMiddle: CGFloat = UIScreen.main.bounds.width * 0
    static let littleRightEdge: CGFloat = UIScreen.main.bounds.width * 0.35
    static let littleLeftEdge: CGFloat = -UIScreen.main.bounds.width * 0.35
    static let rightEdge: CGFloat = UIScreen.main.bounds.width * 0.65
    static let leftEdge: CGFloat = -UIScreen.main.bounds.width * 0.65
    static let verticalMiddle: CGFloat = UIScreen.main.bounds.height * 0
    static let bottomEdge: CGFloat = UIScreen.main.bounds.height * 0.3
    static let topEdge: CGFloat = -UIScreen.main.bounds.height * 0.3
}

class ScenarioViewModel: ObservableObject {
    // Canvas Helpers
    @Published var showDrawingCanvas = false
    @Published var isolatedImages: [UIImage] = []
    
    @Published var animals: [Animal] = []
    
    func addAnimal(_ animal: Animal) {
        DispatchQueue.main.async {
            self.animals.append(animal)
        }
    }
    
    func startHorizontalAnimation(for index: Int) {
        guard index < animals.count else { return }
        
        let randomDuration = Double.random(in: 3...8)
        
        Timer.scheduledTimer(withTimeInterval: randomDuration, repeats: true) { timer in
            if self.animals[index].positionX == Positions.rightEdge {
                self.animals[index].isFlipped = true
            } else {
                self.animals[index].isFlipped = false
            }
            
            withAnimation(Animation.linear(duration: randomDuration)) {
                if self.animals[index].positionX == Positions.rightEdge {
                    self.animals[index].positionX = Positions.leftEdge
                } else {
                    self.animals[index].positionX = Positions.rightEdge
                }
            }
        }
    }

    func startWaveAnimation(for index: Int) {
        guard index < animals.count else { return }
        
        let randomDuration = Double.random(in: 3...8)
        
        Timer.scheduledTimer(withTimeInterval: randomDuration, repeats: true) { timer in
            if self.animals[index].positionX == Positions.rightEdge {
                self.animals[index].isFlipped = true
            } else {
                self.animals[index].isFlipped = false
            }
            
            withAnimation(Animation.linear(duration: randomDuration)) {
                if self.animals[index].positionX == Positions.rightEdge {
                    self.animals[index].positionX = Positions.leftEdge
                } else {
                    self.animals[index].positionX = Positions.rightEdge
                }
            }
        }
    }


    
    func startShakeAnimation(for index: Int) {
        guard index < animals.count else { return }
        withAnimation(Animation.easeInOut(duration: 0.05).repeatForever(autoreverses: true)) {
            self.animals[index].shake.toggle()
        }
    }
    
    func startRotationAnimation(for index: Int) {
        guard index < animals.count else { return }
        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { timer in
            withAnimation {
                self.animals[index].rotationAngle = self.animals[index].angles.randomElement() ?? 0
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
