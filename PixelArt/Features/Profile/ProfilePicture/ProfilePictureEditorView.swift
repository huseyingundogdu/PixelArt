//
//  ProfilePictureEditorView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/07/2025.
//

import SwiftUI

struct ProfilePictureEditorView: View {
    @Environment(\.dismiss) var dismiss
    let appUser: AppUser
    @StateObject private var viewModel: ProfilePictureEditorViewModel
    
    init(
        appUser: AppUser
    ) {
        self.appUser = appUser
        _viewModel = StateObject(wrappedValue: ProfilePictureEditorViewModel(appUser: appUser))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    // SAVE
                    Task { await viewModel.saveUser() }
                    dismiss()
                } label: {
                    Text("Save")
                        .font(.Micro5.medium)
                }
                .foregroundStyle(.black)
                
                Button {
                    viewModel.showGrid.toggle()
                } label: {
                    PixelButton(icon: "ic_grid")
                }
                
                Spacer()
                
                Button {
                    viewModel.operation = .draw
                } label: {
                    PixelButton(icon: "ic_pencil")
                }
                .scaleEffect(viewModel.operation == .draw ? 1.0 : 0.8)
                
                Button {
                    viewModel.operation = .erase
                } label: {
                    PixelButton(icon: "ic_eraser")
                }
                .scaleEffect(viewModel.operation == .erase ? 1.0 : 0.8)
                
                
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
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title)
                }
                .foregroundStyle(.black)
            }
            .padding(.horizontal)
            .background(Color(uiColor: UIColor.gray))
            
            DrawingCanvas(
                data: $viewModel.data,
                selectedColor: $viewModel.selectedColor,
                operation: $viewModel.operation,
                showGrid: $viewModel.showGrid,
                columns: 33,
                rows: 33) { index in
                    switch viewModel.operation {
                    case .draw:
                        viewModel.data[index] = viewModel.selectedColor
                    case .erase:
                        viewModel.data[index] = "#FFFFFF"
                    }
                }
        }
    }
}


