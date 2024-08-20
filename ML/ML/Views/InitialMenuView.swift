//
//  InitialMenuView.swift
//  ML
//
//  Created by Larissa Fazolin on 20/08/24.
//

import SwiftUI

struct InitialMenuView: View {
    @StateObject private var viewModel = InitialMenuViewModel()
    
    var body: some View {
        ZStack {
            BackgroundView()
            colorOverlay()
            
            if viewModel.isScenarioViewActive {
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
            viewModel.isScenarioViewActive = true
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
