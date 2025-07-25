//
//  DrawingCanvasViewWrapper.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 24/07/2025.
//

import SwiftUI

struct DrawingCanvasViewWrapper: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: DrawingCanvasViewModel
    
    init(artwork: ArtworkUIModel) {
        _viewModel = StateObject(wrappedValue: DrawingCanvasViewModel(id: artwork.id))
    }
    
    var body: some View {
        if let entity = viewModel.entity {
            VStack(spacing: 0) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        PixelButton(icon: "ic_arrow")
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.selectedOperation = .draw
                    } label: {
                        PixelButton(icon: "ic_pencil")
                    }
                    .scaleEffect(viewModel.selectedOperation == .draw ? 1.0 : 0.8)
                    Button {
                        viewModel.selectedOperation = .erase
                        
                    } label: {
                        PixelButton(icon: "ic_eraser")
                    }
                    .scaleEffect(viewModel.selectedOperation == .erase ? 1.0 : 0.8)
                    
                    if entity.status != "activeCompetition" {
                        DrawingCanvasColorPicker(
                            selectedColor: $viewModel.selectedColor,
                            colorSheetPresented: $viewModel.isColorSheetPresenting
                        )
                    } else {
                        
                    }
                    
                    
                }
                .padding(.horizontal)
                .background(.gray)
                DrawingCanvas(
                    data: $viewModel.hexData,
                    selectedColor: $viewModel.selectedColor,
                    operation: $viewModel.selectedOperation,
                    columns: Int(entity.width),
                    rows: Int(entity.height)
                ) { index in
                    let newColor: String
                    switch viewModel.selectedOperation {
                    case .draw:
                        newColor = viewModel.selectedColor
                    case .erase:
                        newColor = "#FFFFFF"
                    }
                    viewModel.updatePixel(at: index, to: newColor)
                }
                .ignoresSafeArea()
                
                
                
                
            }
        } else {
            VStack {
                Button("X") {
                    dismiss()
                }
                Text("Artwork not found.")
            }
        }
    }
}

//#Preview {
//    DrawingCanvasColorPickerPreview()
//}

struct DrawingCanvasColorPicker: View {
    @Binding var selectedColor: String
    @Binding var colorSheetPresented: Bool
    
    let colors = ["#79ADDC", "#FFC09F", "#FFEE93", "#ADF7B6"]
    
    var body: some View {
        
        ColorButton(color: selectedColor) {
            colorSheetPresented = true
        }
        .sheet(isPresented: $colorSheetPresented) {
            ColorPaletteView(
                colors: colors,
                selectedColor: selectedColor
            ) { newColor in
                selectedColor = newColor
                colorSheetPresented = false
            }
            .presentationDetents([.medium])
            .background(.gray)
        }
        
    }
}


struct ColorPaletteView: View {
    @Environment(\.dismiss) var dismiss
    let colors: [String]
    let selectedColor: String
    let onSelect: (String) -> Void
    
    let columns = [GridItem(.adaptive(minimum: 50, maximum: 50))]
    
    var body: some View {
        VStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .foregroundStyle(.black)
            .padding()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(colors, id: \.self) { color in
                        ColorPickerButton(
                            item: color,
                            isSelected: color == selectedColor
                        ) {
                            onSelect(color)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct ColorButton: View {
    let color: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Rectangle()
                .fill(Color(hex: color))
                .frame(width: 25, height: 25)
                .pixelBackground(paddingValue: 10)
        }
    }
}

struct ColorPickerButton: View {
    let item: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Rectangle()
            .fill(Color(hex: item))
            .frame(width: 50, height: 50)
            .padding(5)
            .overlay {
                if isSelected {
                    Rectangle()
                        .stroke(Color.white)
                }
            }
            .onTapGesture(perform: action)
    }
}

