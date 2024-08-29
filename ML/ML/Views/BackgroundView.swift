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
            
            let objectWidth: CGFloat = UIScreen.main.bounds.width * 1.1
            let objectHeight: CGFloat = UIScreen.main.bounds.width
            
            Image("scenario")
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)
                .frame(width: objectWidth, height: objectHeight)
                .position(x: moveRight ? screenWidth/2 - objectWidth * 0.04 : screenWidth/2 + objectWidth * 0.04, y: screenHeight/2)
                .onAppear {
                    withAnimation(Animation.linear(duration: 25.0).repeatForever(autoreverses: true)) {
                        moveRight.toggle()
                    }
                }
        }
    }
}



