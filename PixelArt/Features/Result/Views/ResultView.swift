//
//  ResultView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 04/07/2025.
//

import SwiftUI

struct ResultView: View {
    
    @StateObject private var viewModel: ResultViewModel
    @Binding var path: NavigationPath
    let competition: Competition
    
    init(path: Binding<NavigationPath>, competition: Competition) {
        _viewModel = StateObject(wrappedValue: ResultViewModel(competition: competition))
        self._path = path
        self.competition = competition
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(
                title: "Result",
                subtitle: "\(competition.topic)",
                leadingButtonIcon: "ic_arrow",
                leadingButtonAction: { path.removeLast() }
            )
            
            contentView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hex: "d4d4d4"))
        }
        .onAppear {
            Task { await viewModel.loadArchivedArtworks() }
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .navigationBar)
    }
    

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .none, .loading:
            ProgressView("Loading Artworks...")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .font(.custom("Micro5-Regular", size: 32))
        case .success(let artworks):
            
            ResultContentView(competition: competition, artworks: artworks)
            
        case .error(let error):
            VStack(spacing: 16) {
                Text("\(error.localizedDescription)")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.red)
                Button("Try Again") {
                    viewModel.retry()
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
    ResultView(path: .constant(NavigationPath()), competition: MockData.competition)
}
