//
//  PastCompetitionsView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/06/2025.
//

import SwiftUI

struct PastCompetitionsView: View {
    @EnvironmentObject private var router: NavigationRouter
    let appState: AppState
    
    @StateObject private var viewModel: PastCompetitionsViewModel

    
    init(
        appState: AppState
    ) {
        self.appState = appState
        _viewModel = StateObject(wrappedValue: PastCompetitionsViewModel(appState: appState))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(
                title: "Competitions",
                subtitle: "Past",
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
            Task { await viewModel.loadPastCompetitions() }
        }
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .none, .loading:
            ProgressView("Loading past competitions...")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
        case .success(let pastCompetitions):
            PastCompetitionsContentView(pastCompetitions: pastCompetitions)
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

