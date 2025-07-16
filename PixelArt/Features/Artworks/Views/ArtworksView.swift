//
//  ArtworksView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import SwiftUI

struct ArtworksView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = ArtworkViewModel()
    @State private var showCreateConfirmation = false
    @State private var width: String = ""
    @State private var height: String = ""
    @State private var isSizeLocked: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            CustomNavBar(
                title: "Artworks",
                trailingButtonIcon: "ic_plus",
                trailingButtonAction: {
                    showCreateConfirmation = true
                }
            )
            
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading Artworks...")
                        .font(.custom("Micro5-Regular", size: 32))
                } else if let error = viewModel.error {
                    VStack(spacing: 16) {
                        Text("Error: \(error.localizedDescription)")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.red)
                        Button("Try Again") {
                            Task { await viewModel.loadUserArtworks() }
                        }
                        .pixelBackground(paddingValue: 12)
                    }
                } else {
                    ArtworksContentView(
                        personal: viewModel.personalArtworks,
                        shared: viewModel.sharedArtworks,
                        active: viewModel.activeCompetitionArtworks,
                        archived: viewModel.archivedArtworks
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color(hex: "d4d4d4"))
        .onAppear {
            if let user = appState.currentUser {
                Task { await viewModel.setUserAndLoad(user: user) }
            }
        }
        .overlayAlert(
            isPresented: $showCreateConfirmation,
            title: "Select size of freeform artwork",
            confirmText: "Create",
            message: {
                VStack {
                    HStack(alignment: .center) {
                        
                        TextField("", text: $width)
                            .pixelBackground(paddingValue: 10)
                        
                        Button {
                            isSizeLocked.toggle()
                        } label: {
                            Image(isSizeLocked ? "ic_connected" : "ic_unconnected")
                                .resizable()
                                .interpolation(.none)
                                .frame(width: 30, height: 30)
                            
                        }
                        
                        TextField("", text: isSizeLocked ? $width : $height)
                            .pixelBackground(paddingValue: 10)
                        
                    }
                    HStack {
                        Text("Width")
                        Spacer()
                        Text("Height")
                    }
                    .frame(maxWidth: .infinity)
                }
            },
            onConfirm: {
                print("Width: \(width)")
                print("Height: \(height)")
            }
        )
        
    }
}

#Preview {
    ArtworksView()
        .environmentObject(AppState())
}
