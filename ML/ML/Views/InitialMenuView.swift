//
//  InitialMenuView.swift
//  ML
//
//  Created by Larissa Fazolin on 20/08/24.
//

import SwiftUI

struct InitialMenuView: View {
    @State private var isScenarioViewActive = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            colorOverlay()
            
            if isScenarioViewActive {
                ScenarioView()
            } else {
                VStack {
                    startButton()
                }
            }
        }
    }
    
    private func colorOverlay() -> some View {
        Rectangle()
            .edgesIgnoringSafeArea(.all)
            .foregroundStyle(Color("initialMenuColor").opacity(0.4))
    }
    
    private func startButton() -> some View {
        Button(action: {
            isScenarioViewActive = true
        }) {
            Text("Start")
                .font(.system(size: 64, weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, 50)
                .padding(.vertical)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color("buttonColor"))
                )
        }
    }
}
