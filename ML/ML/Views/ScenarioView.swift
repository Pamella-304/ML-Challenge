//
//  ContentView.swift
//  ML
//
//  Created by Pamella Alvarenga on 30/07/24.
//

import SwiftUI

struct ScenarioView: View {
    @State private var showDrawingCanvas = false
    
    var body: some View {
            ZStack {
                Image("aquario")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Button(action: {
                        showDrawingCanvas.toggle()
                    }) {
                        Image(systemName: "pencil")
                            .imageScale(.large)
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                    }.sheet(isPresented: $showDrawingCanvas) {
                        DrawingCanvasView()
                    }
                }
            }
            
            
        
    }
}

#Preview {
    ScenarioView()
}
