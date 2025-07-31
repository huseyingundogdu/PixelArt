//
//  ArtworksView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import SwiftUI

struct ArtworksView: View {
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    let appState: AppState
    @StateObject private var viewModel: ArtworkViewModel
    
    init(appState: AppState) {
        self.appState = appState
        _viewModel = StateObject(wrappedValue: ArtworkViewModel(appState: appState))
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            CustomNavBar(
                title: "Artworks",
                subtitle: networkMonitor.isConnected ? "Online mode" : "Offline Mode",
                trailingButtonIcon: "ic_plus",
                trailingButtonAction: {
                    viewModel.showCreateConfirmation = true
                }
            )
                        
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading Artworks...")
                        
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
                        viewModel: viewModel,
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
            Task { await viewModel.refreshArtworks() }
        }
        .fullScreenCover(item: $viewModel.selectedArtwork, onDismiss: {
            Task { await viewModel.refreshArtworks() }
        }, content: { artwork in
            
            DrawingCanvasViewWrapper(artwork: artwork)
            
        })
        .overlayAlert(
            isPresented: $viewModel.showCreateConfirmation,
            title: "Freeform artwork",
            confirmText: "Create",
            message: {
                VStack {
                    TextField("Title", text: $viewModel.freeformArtworkTopic)
                        .frame(maxWidth: .infinity)
                        .pixelBackground(paddingValue: 10)
                    
                    HStack(alignment: .center) {
                        
                        TextField("", value: $viewModel.width, format: .number)
                            .pixelBackground(paddingValue: 10)
                        
                        Button {
                            viewModel.isSizeLocked.toggle()
                        } label: {
                            Image(viewModel.isSizeLocked ? "ic_connected" : "ic_unconnected")
                                .resizable()
                                .interpolation(.none)
                                .frame(width: 30, height: 30)
                            
                        }
                        
                        TextField("", value: viewModel.isSizeLocked ? $viewModel.width : $viewModel.height, format: .number)
                            .pixelBackground(paddingValue: 10)
                        
                    }
                    HStack {
                        Text("Width")
                        Spacer()
                        Text("Height")
                    }
                    .frame(maxWidth: .infinity)
                    
                    Text("Height or Width cannot be 0.")
                        .opacity(viewModel.hasSizeError ? 1.0 : 0.0)
                        .foregroundStyle(.red)
                }
            },
            onConfirm: {
                Task {
                    //FIXME: Buradaki logic i view model ayarlasin
                    if viewModel.isSizeLocked {
                        await viewModel.createArtwork(width: viewModel.width, height: viewModel.width)
                    } else {
                        await viewModel.createArtwork(width: viewModel.width, height: viewModel.height)
                    }
                }
            }
        )
        
    }
}

//#Preview {
//    ArtworksView()
//        .environmentObject(AppState())
//}
