//
//  InitialMenuView.swift
//  ML
//
//  Created by Larissa Fazolin on 20/08/24.
//

import SwiftUI

struct InitialMenuView: View {
    var body: some View {
        ZStack {
            BackgroundView()
            colorOverlay()
            
            VStack {
                startButton()
            }
        }
    }
    
    private func colorOverlay() -> some View {
        Rectangle()
            .edgesIgnoringSafeArea(.all)
            .foregroundStyle(Color("initialMenuColor").opacity(0.4))
    }
    
    private func startButton() -> some View {
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
