//
//  AnimalModel.swift
//  ML
//
//  Created by Larissa Fazolin on 08/08/24.
//

import SwiftUI

class Animal: ObservableObject {
    let name: String
    let animationType: AnimationType
    @Published var positionX: CGFloat
    @Published var positionY: CGFloat
    @Published var image: UIImage
    
    init(name: String,  animationType: AnimationType, positionX: CGFloat, positionY: CGFloat, image: UIImage) {
        self.name = name
        self.animationType = animationType
        self.positionX = positionX
        self.positionY = positionY
        self.image = image
    }
}
