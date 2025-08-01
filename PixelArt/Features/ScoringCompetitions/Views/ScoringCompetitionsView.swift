//
//  ScoringCompetitionsView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/06/2025.
//

import SwiftUI

struct ScoringCompetitionsView: View {
    @EnvironmentObject private var router: NavigationRouter
    let appState: AppState
    
    @StateObject private var viewModel: ScoringCompetitionsViewModel

    init(
        appState: AppState
    ) {
        self.appState = appState
        _viewModel = StateObject(wrappedValue: ScoringCompetitionsViewModel(appState: appState))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(
                title: "Competition",
                subtitle: "Scoring",
                leadingButtonIcon: "ic_arrow",
                leadingButtonAction: {
                    router.competitionRoutes.removeLast()
                }
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
            ProgressView("Loading scoring competitions...")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
        case .success(let scoringCompetitions):
            
            ScoringCompetitionsContentView(scoringCompetitions: scoringCompetitions)
            
        case .error(let error):
            VStack(spacing: 16) {
                Text("\(error.localizedDescription)")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.red)
                Button("Try Again") {
                    viewModel.retry()
                }
                .pixelBackground(paddingValue: 12)
            }
            
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding()
        }
    }
}

