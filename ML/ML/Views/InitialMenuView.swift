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
        }
    }
    
    private func colorOverlay() -> some View {
        Rectangle()
            .edgesIgnoringSafeArea(.all)
            .foregroundStyle(Color("initialMenuColor").opacity(0.4))
    }
}
