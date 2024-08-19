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
    let image: UIImage
    var positionX: CGFloat
    var positionY: CGFloat
    let animationType: AnimationType
}

let animals: [String: Animal] = [
    "starfish": Animal(name: "starfish", image: UIImage(imageLiteralResourceName: "starfish"),
                       positionX: CGFloat.random(in: Positions.littleLeftEdge...Positions.littleRightEdge),
                       positionY: Positions.bottomEdge,
                       animationType: .shake),
    "shark": Animal(name: "shark", image: UIImage(imageLiteralResourceName: "shark"),
                    positionX: [Positions.leftEdge, Positions.rightEdge].randomElement() ?? 0,
                    positionY: [Positions.bottomEdge, Positions.topEdge, Positions.verticalMiddle].randomElement() ?? 0,
                    animationType: .horizontal),
    "fish": Animal(name: "fish", image: UIImage(imageLiteralResourceName: "fish"),
                   positionX: [Positions.leftEdge, Positions.rightEdge].randomElement() ?? 0,
                   positionY: Positions.verticalMiddle,
                   animationType: .wave)
]
