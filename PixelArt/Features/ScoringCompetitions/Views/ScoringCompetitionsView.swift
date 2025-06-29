//
//  ScoringCompetitionsView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/06/2025.
//

import SwiftUI

struct ScoringCompetitionsView: View {
    
    @StateObject private var viewModel = ScoringCompetitionsViewModel()
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(
                title: "Competition",
                subtitle: "Scoring",
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
            ProgressView("Loading scoring competitions...")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .font(.custom("Micro5-Regular", size: 32))
        case .success(let scoringCompetitions):
            
            ScoringCompetitionsContentView(path: $path, scoringCompetitions: scoringCompetitions)
            
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
    ScoringCompetitionsView(path: .constant(NavigationPath()))
}
