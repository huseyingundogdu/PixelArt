//
//  ArtworksView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import SwiftUI

struct ArtworksView: View {
    
    @StateObject private var viewModel = ArtworkViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(
                title: "Artworks"
            )
            contentView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hex: "d4d4d4"))
        }
        .onAppear {
            if case .none = viewModel.state {
                viewModel.retry()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .refreshArtworks)) { _ in
            Task {
                print("Refreshing artworks...")
                await viewModel.loadCurrentUserArtworks()
            }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .none, .loading:
            ProgressView("Loading...")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .font(.custom("Micro5-Regular", size: 32))
        case .success(let artworks):
            ArtworksContentView(artworks: artworks)
        case .error(let error):
            VStack(spacing: 16) {
                Text("\(error.localizedDescription)")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.red)
                Button("Try Again") {
                    print("tried again")
                }
                .pixelBackground(paddingValue: 12)
            }
            .font(.custom("Micro5-Regular", size: 32))
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding()
        }
    }
    
}

#Preview {
    ArtworksView()
}
