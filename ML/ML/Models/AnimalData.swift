//
//  AnimalCharacteristics.swift
//  ML
//
//  Created by Larissa Fazolin on 16/08/24.
//

import Foundation
import SwiftUI

enum AnimationType {
    case horizontal
    case wave
    case shake
}

struct Animal {
    let name: String
    var positionX: CGFloat
    var positionY: CGFloat
    let animationType: AnimationType

    var rotationAngle: Double = 0
    var isFlipped: Bool = false
    var shake: Bool = false
    let angles: [Double] = [0, 5, 10, 15, 20, 25]
}

func createAnimal(for category: String) -> Animal? {
    switch category {
    case "Crustaceans":
        return Animal(name: "Crustaceans",
                      positionX: Positions.leftEdge,
                      positionY: Positions.bottomEdge,
                      animationType: .horizontal)
    case "DolphinFish":
        return Animal(name: "DolphinFish",
                      positionX: Positions.leftEdge,
                      positionY: Positions.verticalMiddle,
                      animationType: .wave)
    case "Oyster":
        return Animal(name: "Oyster",
                      positionX: CGFloat.random(in: Positions.littleLeftEdge...Positions.littleRightEdge),
                      positionY: Positions.bottomEdge,
                      animationType: .shake)
    case "SeaHorse":
        return Animal(name: "SeaHorse",
                      positionX: Positions.leftEdge,
                      positionY: [Positions.bottomEdge, Positions.topEdge, Positions.verticalMiddle].randomElement() ?? 0,
                      animationType: .horizontal)
    case "Snail":
        return Animal(name: "Snail",
                      positionX: Positions.leftEdge,
                      positionY: Positions.bottomEdge,
                      animationType: .horizontal)
    case "Star":
        return Animal(name: "Star",
                      positionX: CGFloat.random(in: Positions.littleLeftEdge...Positions.littleRightEdge),
                      positionY: Positions.bottomEdge,
                      animationType: .shake)
    case "Tentacles":
        return Animal(name: "Tentacles",
                      positionX: Positions.leftEdge,
                      positionY: Positions.verticalMiddle,
                      animationType: .wave)
    case "Urchin":
        return Animal(name: "Urchin",
                      positionX: CGFloat.random(in: Positions.littleLeftEdge...Positions.littleRightEdge),
                      positionY: Positions.bottomEdge,
                      animationType: .shake)
    default:
        return nil
    }
}
