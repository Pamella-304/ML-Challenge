//
//  StarAnimation.swift
//  ML
//
//  Created by Carol Quiterio on 28/08/24.
//

import SwiftUI

struct SwimAnimationView: View {
    
    let uiImage: UIImage
    let randomHeight: Double
    
    @State private var moveRight = true
    @State private var flip = true
    
    let startDate = Date()
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            let objectWidth: CGFloat = UIScreen.main.bounds.width * 0.2
            let objectHeight: CGFloat = UIScreen.main.bounds.width * 0.2
            
            
            TimelineView(.animation) { tl in
                let time = startDate.distance(to: tl.date)
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: objectWidth, height: objectWidth)
                    .padding(.vertical, 80)
                    .drawingGroup()
                    .swimAnimation(time: Float(time), size: 50, positionX: 0.0)
                    .position(x: moveRight ? screenWidth - objectWidth / 2 : objectWidth / 2, y: getHeight(screenHeight))
                    .scaleEffect(flip ? 1 : -1)
                    .onAppear {
                        withAnimation(Animation.linear(duration: 6.0).repeatForever(autoreverses: true)) {
                            moveRight.toggle()
                        }
                    }
                    .onChange(of: moveRight) { newValue in
                        flip.toggle()
                    }
            }
        }
    }
    
    private func getHeight(_ screenHeight: CGFloat) -> Double {
        let maxHeight = screenHeight - UIScreen.main.bounds.width * 0.3 / 2
        let minHeight = UIScreen.main.bounds.width * 0.3 / 2
        
        if randomHeight > maxHeight {
            return maxHeight
        } else if randomHeight < minHeight {
            return minHeight
        } else {
            return randomHeight
        }
    }
}

extension View {
    func swimAnimation(time: Float, size: Float, positionX: Double) -> some View {
        self
            .distortionEffect(
                ShaderLibrary.jump(
                    .float(time)
                ),
                maxSampleOffset: .zero
            )
            .distortionEffect(
                ShaderLibrary.wave(
                    .float(time)
                ),
                maxSampleOffset: .zero
            )
    }
}
    
#Preview {
    SwimAnimationView(uiImage: UIImage(named: "scenario") ?? UIImage(), randomHeight: 900)
}
