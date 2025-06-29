//
//  CompetitionView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import SwiftUI
import FirebaseFirestore
import FirebaseCore

enum CompetitionTo: Hashable {
    case scoringCompetitions
    case allCompetitions
    case voting(Competition)
}

struct CompetitionView: View {
    
    @StateObject private var viewModel = CompetitionViewModel()
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                
                CustomNavBar(
                    title: "Competition",
                    leadingButtonIcon: "ic_comp",
                    leadingButtonAction: {
                        path.append(CompetitionTo.scoringCompetitions)
                    },
                    trailingButtonIcon: "ic_crown") {
                        path.append(CompetitionTo.allCompetitions)
                    }
                
                
                contentView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(hex: "d4d4d4"))
            }
            .onAppear {
                if case .none = viewModel.state {
                    viewModel.retry()
                }
            }
            .navigationDestination(for: CompetitionTo.self) { destinationValue in
                switch destinationValue {
                case .allCompetitions:
                    PastCompetitionsView(path: $path)
                case .scoringCompetitions:
                    ScoringCompetitionsView(path: $path)
                case .voting(let competition):
                    VotingView(path: $path, competition: competition)
                }
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
        case .success(let competition):
            
            CompetitionContentView(competition: competition, currentUserId: "currentUserId")
            
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
    CompetitionView()
}
