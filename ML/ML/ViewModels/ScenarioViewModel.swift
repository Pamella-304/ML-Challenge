//
//  ScenarioViewModel.swift
//  ML
//
//  Created by Pamella Alvarenga on 31/07/24.
//

import SwiftUI

class ScenarioViewModel: ObservableObject {
    @Published var isolatedImages: [UIImage] = []
    
    func addImage(_ image: UIImage) {
            isolatedImages.append(image)
        //print("lista de imagens:")
        //print(isolatedImages)
        }
}
