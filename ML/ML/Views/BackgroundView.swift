//
//  BackgroundView.swift
//  ML
//
//  Created by Larissa Fazolin on 20/08/24.
//

import SwiftUI

struct BackgroundView: View {
    
    @State private var moveRight = true
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            let objectWidth: CGFloat = UIScreen.main.bounds.width
            let objectHeight: CGFloat = UIScreen.main.bounds.width
            
            Image("scenario")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .position(x: moveRight ? screenWidth - objectWidth / 2 : objectWidth / 2, y: screenHeight)
                .onAppear {
                    withAnimation(Animation.linear(duration: 18.0).repeatForever(autoreverses: true)) {
                        moveRight.toggle()
                    }
                }
            
        }
    }
}
