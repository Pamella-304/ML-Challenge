//
//  CutomizedToolBars.swift
//  ML
//
//  Created by Pamella Alvarenga on 29/08/24.
//

import SwiftUI

struct CutomizedToolBarScenario: View {
    @Binding var isCanvasViewActive: Bool
    
    
    var body: some View {

        HStack {
            
            Menu {
                Button(action: {
                    print("options")
                }) {
                    MenuButtonLabel(text: "Options", color: .gray)
                }
                Button(action: {
                    
                    isCanvasViewActive = true
                    
                }) {
                    MenuButtonLabel(text: "New Drawing", color: .blue)
                }
                Button(action: {
                    print("reset scenario")
                }) {
                    MenuButtonLabel(text: "Reset Scenario", color: .red)
                }
            } label: {
                Image("optionButton")
                    .resizable()
                    .frame(width: 88, height: 88)
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                isCanvasViewActive = true
            }) {
                Image("drawButton")
            }
            .padding()
            
        }

    }
}


struct MenuButtonLabel: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.headline) // Defina a fonte uma vez aqui
            .foregroundColor(color) // Defina a cor fornecida
            .padding(5) // Adiciona padding se necessário
    }
}

struct CutomizedToolBarCanvas: View {
        
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        HStack {
            
            Button(action: {
                @Environment(\.presentationMode) var presentationMode
            },
                   label: {
                Image("undefined")
            })
            .padding()
            
            Spacer()
            
            Button(action: {
                
                presentationMode.wrappedValue.dismiss()

            },
                   label: {
                Image("addDrawingButton")
            })
            .padding()
        }
    }
}

protocol ToolBarDelegate: AnyObject {
    func addDrawingToScenario(_ image: UIImage)
}
