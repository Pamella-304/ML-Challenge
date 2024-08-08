//
//  AnimalModel.swift
//  ML
//
//  Created by Larissa Fazolin on 08/08/24.
//

import SwiftUI

class AnimalModel {
    let name: String
    var image: UIImage
    var positionX: CGFloat
    var positionY: CGFloat
    let animationType: AnimationType
    var animationDuration: Double
    
    init(name: String, image: UIImage, positionX: CGFloat, positionY: CGFloat, animationType: AnimationType, animationDuration: Double) {
        self.name = name
        self.image = image
        self.positionX = positionX
        self.positionY = positionY
        self.animationType = animationType
        self.animationDuration = animationDuration
    }
}
