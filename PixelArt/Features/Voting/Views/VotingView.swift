//
//  VotingView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 29/06/2025.
//

import SwiftUI

struct VotingView: View {
    @EnvironmentObject private var router: NavigationRouter
    
    @StateObject private var viewModel: VotingViewModel
    let competition: Competition
    
    init(competition: Competition) {
        _viewModel = StateObject(wrappedValue: VotingViewModel(competition: competition))
        self.competition = competition
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(
                title: "Voting",
                subtitle: "\(competition.topic)",
                leadingButtonIcon: "ic_arrow",
                leadingButtonAction: {
                    router.competitionRoutes.removeLast()
                },
                trailingText: "\(viewModel.usedLike)/\(viewModel.totalLike)"

            )
            
            contentView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hex: "d4d4d4"))
        }
        .onAppear {
            viewModel.retry()
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
                
        case .success(let artworks):
            
            VotingContentView(
                viewModel: viewModel,
                competition: competition,
                artworks: artworks
            )
            
        case .error(let error):
            VStack(spacing: 16) {
                Text("\(error.localizedDescription)")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.red)
                Button("Try Again") {
                    
                }
                .pixelBackground(paddingValue: 12)
            }
            
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding()
        }
    }
}

#Preview {
    VotingView(competition: MockData.competition)
}
