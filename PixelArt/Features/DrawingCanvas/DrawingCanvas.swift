//
//  ContentView.swift
//  PixelDrawingCanvas
//
//  Created by Hüseyin Gündoğdu on 22/07/2025.
//

import SwiftUI

// MARK: - Main ContentView
struct DrawingCanvas: View {
    // Grid dimensions
    let columns: Int
    let rows: Int

    
    // State for the SwiftUI controls
    @Binding var data: [String]
    @Binding var selectedColor: String
    @Binding var operation: Operation
    @State private var showGrid: Bool = true
    
    // State to trigger clearing the canvas
    @State private var clearCanvas: Bool = false
    @State private var resetTransform: Bool = false
    
    let onPixelIndex: (Int) -> (Void)
    
    init(data: Binding<[String]>, selectedColor: Binding<String>, operation: Binding<Operation>, columns: Int, rows: Int, onPixelIndex: @escaping (Int) -> Void) {
        // Initialize the data array with the correct size based on the grid dimensions
        self._data = data
        self.columns = columns
        self.rows = rows
        _selectedColor = selectedColor
        _operation = operation
        self.onPixelIndex = onPixelIndex
    }

    var body: some View {
        ZStack {
            // The UIKit-based Pixel Canvas View
            // It handles all drawing and gestures internally.
            PixelCanvasView(
                data: $data,
                columns: columns,
                rows: rows,
                selectedColor: $selectedColor, 
                operation: $operation,
                clearCanvas: $clearCanvas,
                showGrid: $showGrid,
                resetTransform: $resetTransform
            )
            .ignoresSafeArea()
            .onChange(of: data) { oldValue, newValue in
                // Find all changed indices and call onPixelChange for each
        
                for (index, (old, new)) in zip(oldValue, newValue).enumerated() {
                    if old != new {
                        onPixelIndex(index)
                    }
                }
        
                
            }

            // MARK: - UI Controls
//            VStack {
//                HStack {
//                    // Color Picker
//                    ColorPicker("Color", selection: Binding(
//                        get: { Color(hex: selectedColor) },
//                        set: { newColor in selectedColor = newColor.toHex() ?? selectedColor }
//                    ))
//                    .labelsHidden()
//                    .padding()
//                    .background(Color.white.opacity(0.8))
//                    .cornerRadius(10)
//                    .padding(.leading)
//
//                    // Clear Button
//                    Button(action: {
//                        // Set the command to clear the canvas
//                        clearCanvas = true
//                    }) {
//                        Image(systemName: "trash")
//                            .padding()
//                            .background(Color.white.opacity(0.8))
//                            .foregroundColor(.red)
//                            .cornerRadius(10)
//                    }
//                    .padding(.leading)
//
//                    // Grid Toggle
//                    Toggle(isOn: $showGrid) {
//                        Image(systemName: "square.grid.2x2")
//                    }
//                    .toggleStyle(.button)
//                    .padding()
//                    .background(Color.white.opacity(0.8))
//                    .cornerRadius(10)
//                    .padding(.leading)
//                    
//                    // Reset View Button
//                    Button(action: {
//                        resetTransform = true
//                    }) {
//                        Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
//                            .padding()
//                            .background(Color.white.opacity(0.8))
//                            .foregroundColor(.blue)
//                            .cornerRadius(10)
//                    }
//                    .padding(.leading)
//
//                    Spacer()
//                }
//                .padding(.top, 8)
//                Spacer()
//            }
        }
    }
}

// We keep this extension here for the ColorPicker binding
// MARK: - Color to Hex Conversion Helper
extension Color {
    // Convert Color to hex string (for ColorPicker binding)
    func toHex() -> String? {
        let uiColor = UIColor(self)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }
        let r = Int(red * 255)
        let g = Int(green * 255)
        let b = Int(blue * 255)
        return String(format: "#%02x%02x%02x", r, g, b)
    }
}
