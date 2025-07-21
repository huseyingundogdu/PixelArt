//
//  CompetitionView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import SwiftUI
import FirebaseFirestore
import FirebaseCore

struct CompetitionView: View {
    let appState: AppState
    @EnvironmentObject private var router: NavigationRouter
    @StateObject private var viewModel: CompetitionViewModel

    
    init(appState: AppState) {
        self.appState = appState
        _viewModel = StateObject(wrappedValue: CompetitionViewModel(appState: appState))
    }
    
    var body: some View {

            VStack(spacing: 0) {
                
                CustomNavBar(
                    title: "Competition",
                    leadingButtonIcon: "ic_comp",
                    leadingButtonAction: {
                        router.competitionRoutes.append(.scoringCompetitions)
                    },
                    trailingButtonIcon: "ic_crown") {
                        router.competitionRoutes.append(.pastCompetitions)
                    }
                
                
                contentView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(hex: "d4d4d4"))
            }
            .onAppear { 
                Task { await viewModel.loadActiveCompetition() }
            }
        
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .none, .loading:
            ProgressView("Loading...")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .font(.custom("Micro5-Regular", size: 32))
        case .success(let competition):
            
            CompetitionContentView(
                competition: competition,
                viewModel: viewModel
            )
            
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
