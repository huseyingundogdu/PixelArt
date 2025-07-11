//
//  VotingView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 29/06/2025.
//

import SwiftUI

struct VotingView: View {
    @StateObject private var viewModel: VotingViewModel
    @Binding var path: NavigationPath
    let competition: Competition
    
    init(path: Binding<NavigationPath>, competition: Competition) {
        _viewModel = StateObject(wrappedValue: VotingViewModel(competition: competition))
        self._path = path
        self.competition = competition
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(
                title: "Voting",
                subtitle: "\(competition.topic)",
                leadingButtonIcon: "ic_arrow",
                leadingButtonAction: {
                    path.removeLast()
                }
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
        .toolbar(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .none, .loading:
            ProgressView("Loading artworks...")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .font(.custom("Micro5-Regular", size: 32))
        case .success(let artworks):
            
            VotingContentView(competition: competition ,artworks: artworks)
            
        case .error(let error):
            VStack(spacing: 16) {
                Text("\(error.localizedDescription)")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.red)
                Button("Try Again") {
                    
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
    VotingView(path: .constant(NavigationPath()), competition: MockData.competition)
}
