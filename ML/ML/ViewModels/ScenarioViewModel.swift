//
//  ScenarioViewModel.swift
//  ML
//
//  Created by Pamella Alvarenga on 31/07/24.
//

import SwiftUI

class ScenarioViewModel: ObservableObject {
    @Published var showDrawingCanvas = false

    func toggleDrawingCanvas() {
        showDrawingCanvas.toggle()
    }
}
