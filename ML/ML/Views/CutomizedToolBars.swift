//
//  CutomizedToolBars.swift
//  ML
//
//  Created by Pamella Alvarenga on 29/08/24.
//

import SwiftUI

struct CutomizedToolBarScenario: View {
    @Binding var isCanvasViewActive: Bool
    @ObservedObject var viewModel: ScenarioViewModel

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
                    
                    viewModel.resetScenario()
                    
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
            .font(.headline)
            .foregroundColor(color)
            .padding(5)
    }
}

struct CustomizedToolBarCanvas: View {
    @Environment(\.presentationMode) var presentationMode
    var onAdd: (UIImage) -> Void
    @ObservedObject var viewModel: DrawingCanvasViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                // Handle dismissal only if no alert is being shown
                if !viewModel.showAlert {
                    presentationMode.wrappedValue.dismiss()
                }
            },
            label: {
                Image("undefined")
            })
            .padding()
            
            Spacer()
            
            Button(action: {
                viewModel.processDrawing { isolatedImage in
                    if let image = isolatedImage {
                        onAdd(image)
                        // Control dismissal after processing
                        if !viewModel.showAlert {
                            presentationMode.wrappedValue.dismiss()
                        }
                    } else {
                        print("No image was generated")
                    }
                }
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
