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
                    
                    Text("Options")
                    
                }
                Button(role: .destructive, action: {
    
                    isCanvasViewActive = true
    
                }) {
                    
                    Text("New Drawing")
                    
                }
                Button(action: {
                    
                    viewModel.resetScenario()
                    
                }) {
                    
                    Text("Reset Scenario")
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
