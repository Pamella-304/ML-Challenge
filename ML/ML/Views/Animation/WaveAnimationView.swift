//
//  WaveAnimationView.swift
//  ML
//
//  Created by Carol Quiterio on 29/08/24.
//

import SwiftUI

struct WaveAnimationView: View {
    
    let uiImage: UIImage
    let randomHeight: Double
    let randomWidth: Double
    
    @State private var moveRight = true
    @State private var flip = true
    
    let startDate = Date()
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            let objectWidth: CGFloat = UIScreen.main.bounds.width * 0.12
            let objectHeight: CGFloat = UIScreen.main.bounds.width * 0.12
            
            
            TimelineView(.animation) { tl in
                let time = startDate.distance(to: tl.date)
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: objectWidth, height: objectWidth)
                    .padding(.vertical, 80)
                    .drawingGroup()
                    .waveAnimation(time: Float(time))
                    .position(
                        x: getWidth(screenWidth),
                        y: getHeight(screenHeight)
                    )
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
    
    private func getWidth(_ screenWidth: CGFloat) -> Double {
        let maxWidth = screenWidth - UIScreen.main.bounds.width * 0.3 / 2
        let minWidth = UIScreen.main.bounds.width * 0.3 / 2
        
        if randomWidth > maxWidth {
            return maxWidth
        } else if randomWidth < minWidth {
            return minWidth
        } else {
            return randomWidth
        }
    }
}



extension View {
    func waveAnimation(time: Float) -> some View {
        self.distortionEffect(ShaderLibrary.wave(.float(time)), maxSampleOffset: .zero)
    }
}
    
#Preview {
    WaveAnimationView(uiImage: UIImage(named: "scenario") ?? UIImage(), randomHeight: 500, randomWidth: 500)
}
