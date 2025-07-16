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
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            CustomNavBar(
                title: "Artworks"
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
//        .onReceive(NotificationCenter.default.publisher(for: .refreshArtworks)) { _ in
//            Task {
//                print("Refreshing artworks...")
//                await viewModel.retry()
//            }
//        }
    }
}

#Preview {
    ArtworksView()
        .environmentObject(AppState())
}
