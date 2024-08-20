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
                VStack(alignment: .center) {
                    Image("animArt")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.6,
                               height: UIScreen.main.bounds.height * 0.8)
                        .padding(.top, -80)

                        startButton()
                            .background(
                                Image("crab")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.2,
                                           height: UIScreen.main.bounds.height * 0.3)
                                    .padding(.bottom, 300)
                            )
                    
                    Spacer()
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
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, 40)
                .padding(.vertical)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color("buttonColor"))
                )
        }
    }
}
