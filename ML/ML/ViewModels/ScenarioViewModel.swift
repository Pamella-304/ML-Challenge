//
//  ScenarioViewModel.swift
//  ML
//
//  Created by Pamella Alvarenga on 31/07/24.
//

import SwiftUI

class ScenarioViewModel: ObservableObject {
    @Published var showDrawingCanvas = false
    @Published var isFlipped: Bool = false
    @Published var animalPosition: CGFloat = UIScreen.main.bounds.width * 0.65 // starts at right edge
    @Published var rightEdge: CGFloat = UIScreen.main.bounds.width * 0.65
    @Published var leftEdge: CGFloat = -UIScreen.main.bounds.width * 0.65

    func toggleDrawingCanvas() {
        showDrawingCanvas.toggle()
    }
    
    func startHorizontalAnimation(duration: Double) {
        Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { timer in
            withAnimation(Animation.linear(duration: duration)) {
                if self.animalPosition == self.rightEdge {
                    self.animalPosition = self.leftEdge
                } else {
                    self.animalPosition = self.rightEdge
                }
            }
        }
    }
}
