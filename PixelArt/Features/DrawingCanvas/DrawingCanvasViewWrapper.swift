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
                    
                    Button {
                        viewModel.isGridActive.toggle()
                    } label: {
                        PixelButton(icon: "ic_grid")
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
                    
                    
                    if entity.status == "activeCompetition" {
                        if let palette = entity.colorPalette {
                            DrawingCanvasColorPicker(
                                selectedColor: $viewModel.selectedColor,
                                colorSheetPresented: $viewModel.isColorSheetPresenting,
                                palette: palette
                            )
                        }
                    } else {
                        ColorButton(color: viewModel.selectedColor) {
                            viewModel.isColorSheetPresenting = true
                        }
                        .sheet(isPresented: $viewModel.isColorSheetPresenting) {
                            ZStack {
                                Color.gray
                                    .ignoresSafeArea()
                                VStack {
                                    DrawingCanvasColorPickerFreeform(
                                        selectedColor: $viewModel.selectedColor
                                    )
                                    Spacer()
                                }
                            }
                            .presentationDetents([.medium])
                        }
                    }
                    
                    
                    
                }
                .padding(.horizontal)
                .background(Color(uiColor: UIColor.gray))
                DrawingCanvas(
                    data: $viewModel.hexData,
                    selectedColor: $viewModel.selectedColor,
                    operation: $viewModel.selectedOperation,
                    showGrid: $viewModel.isGridActive,
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
    let palette: [String]
    
    var body: some View {
        
        ColorButton(color: selectedColor) {
            colorSheetPresented = true
        }
        .sheet(isPresented: $colorSheetPresented) {
            ColorPaletteView(
                colors: palette,
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


struct DrawingCanvasColorPickerFreeform: View {
    @Binding var selectedColor: String

    @State private var red: Double = 255
    @State private var green: Double = 0
    @State private var blue: Double = 0

    var body: some View {
        VStack(spacing: 16) {
            let displayColor = Color(uiColor: UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0))
            let borderColor = displayColor.isLight ? Color.black : Color.white

            
            ZStack {
                Rectangle()
                    .fill(displayColor)
                    .frame(height: 40)
                    .overlay {
                        Rectangle()
                            .stroke(borderColor, lineWidth: 2)
                    }
                
                Text("Hex: \(hexColor)")
                    .foregroundStyle(borderColor)
            }
            
            
            SmartRGBSlider(label: "RED", value: $red, fixed1: green, fixed2: blue, channel: .red)
            SmartRGBSlider(label: "GREEN", value: $green, fixed1: red, fixed2: blue, channel: .green)
            SmartRGBSlider(label: "BLUE", value: $blue, fixed1: red, fixed2: green, channel: .blue)

            

        }
        .padding()
        .onChange(of: red) {_, _ in updateHex() }
        .onChange(of: green) {_, _ in updateHex() }
        .onChange(of: blue) {_, _ in updateHex() }
        .onAppear {
            // eğer dışardan hex color varsa başlangıçta RGB'ye parse et
            if let rgb = selectedColor.hexToRGB() {
                red = Double(rgb.red)
                green = Double(rgb.green)
                blue = Double(rgb.blue)
            }
        }
    }

    private var hexColor: String {
        String(format: "#%02X%02X%02X", Int(red), Int(green), Int(blue))
    }

    private func updateHex() {
        selectedColor = hexColor
    }
}


struct RGBSlider: View {
    let label: String
    @Binding var value: Double
    let color: Color

    var body: some View {
        HStack {
            Text(label)
                .frame(width: 50, alignment: .leading)
            Slider(value: $value, in: 0...255, step: 1)
                .tint(color)
            Text("\(Int(value))")
                .frame(width: 40)
        }
    }
}

extension String {
    func hexToRGB() -> (red: Int, green: Int, blue: Int)? {
        var hex = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hex.hasPrefix("#") {
            hex.removeFirst()
        }

        guard hex.count == 6,
              let intVal = Int(hex, radix: 16) else { return nil }

        let red = (intVal >> 16) & 0xFF
        let green = (intVal >> 8) & 0xFF
        let blue = intVal & 0xFF

        return (red, green, blue)
    }
}

//MARK: - SmartRGBSlider

struct SmartRGBSlider: View {
    let label: String
    @Binding var value: Double
    let fixed1: Double
    let fixed2: Double
    let channel: RGBChannel

    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Text(label)
                    .frame(width: 50, alignment: .leading)
                Spacer()
                Text("\(Int(value))")
                    .frame(width: 40, alignment: .trailing)
            }

            GeometryReader { geometry in
                
                let thumbColor = Color.currentColor(
                    r: channel == .red ? value : fixed1,
                    g: channel == .green ? value : fixed1,
                    b: channel == .blue ? value : fixed2
                )

                let borderColor = thumbColor.isLight ? Color.black : Color.white
                
                
                ZStack(alignment: .leading) {
                    // Gradient bar
                    Rectangle()
                        .fill(gradient)
                        .frame(height: 20)
                        

                    // Thumb
                    Rectangle()
                        .strokeBorder(borderColor, lineWidth: 2)
                        .background(Circle().fill(thumbColor))
                        .frame(width: 20, height: 20)
                        .offset(x: CGFloat(value / 255) * (geometry.size.width - 20))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    let location = min(max(0, gesture.location.x), geometry.size.width - 20)
                                    value = (location / (geometry.size.width - 20)) * 255
                                }
                        )
                }
            }
            .frame(height: 24) // Yükseklik sabit kalmalı
        }
        .padding(.horizontal, 20)
        .pixelBackground(paddingValue: 10)
    }

    private var gradient: LinearGradient {
        let start = Color.currentColor(r: channel == .red ? 0 : fixed1,
                                       g: channel == .green ? 0 : fixed1,
                                       b: channel == .blue ? 0 : fixed2)

        let end = Color.currentColor(r: channel == .red ? 255 : fixed1,
                                     g: channel == .green ? 255 : fixed1,
                                     b: channel == .blue ? 255 : fixed2)

        return LinearGradient(colors: [start, end], startPoint: .leading, endPoint: .trailing)
    }
}


enum RGBChannel {
    case red, green, blue
}

extension Color {
    static func currentColor(r: Double, g: Double, b: Double) -> Color {
        Color(red: r / 255, green: g / 255, blue: b / 255)
    }
}

extension Color {
    var isLight: Bool {
        let uiColor = UIColor(self)

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)

        // ITU-R BT.601 standardına göre parlaklık hesaplaması
        let brightness = (299 * r + 587 * g + 114 * b) / 1000

        return brightness > 0.7
    }
}



