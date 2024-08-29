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
    
    func toggleDrawingCanvas() {
        showDrawingCanvas.toggle()
    }
    
    func addImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.isolatedImages.append(image)
        }
    }
    
}
