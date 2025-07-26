//
//  CompetitionContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/05/2025.
//

import SwiftUI
import FirebaseCore

private enum StringItems: String {
    case time = "Remaining Time"
    case topic = "Competition Topic"
    case colors = "Colors of competition"
    case join = "Join Competition"
}

struct CompetitionContentView: View {
    let competition: Competition
    
    @ObservedObject var viewModel: CompetitionViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                
                remainingTime(competition.scoringAt)
                competitionTopic(competition.topic)
                colorsOfCompetition(competition.colorPalette)
                
                JoinButtonView(state: viewModel.joinState) {
                    viewModel.showJoinConfirmation = true
                }
                .foregroundStyle(.black)
                .padding(.horizontal)
                .pixelBackground()
                
            }
            .padding()
            
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "d4d4d4"))
        .overlayAlert(
            isPresented: $viewModel.showJoinConfirmation,
            title: "Are you sure?",
            confirmText: "Create"
        ) {
            Text("\(competition.size[0]) x \(competition.size[1]) Canvas with \(competition.topic) theme will be created.")
        } onConfirm: {
            // Firestore’a artwork oluştur
            Task {
                await viewModel.joinCurrentCompetition(competition)
            }
        }
        .onAppear {
            Task { await viewModel.checkIfUserAlreadyJoined(competition) }
        }
    }
    
    private func remainingTime(_ scoringAt: Timestamp) -> some View {
        VStack(spacing: 20) {
            Text(StringItems.time.rawValue)
                .font(.Micro5.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            TimerView(scoringAt: scoringAt)
        }
    }
    
    private func competitionTopic(_ topic: String) -> some View {
        VStack(spacing: 20) {
            Text(StringItems.topic.rawValue)
                .font(.Micro5.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("\"\(topic)\"")
                .font(.Micro5.xxLarge)
                .frame(maxWidth: .infinity, alignment: .center)
                
        }
    }
    
    private func colorsOfCompetition(_ palette: [String]) -> some View {
        VStack(spacing: 20) {
            Text(StringItems.colors.rawValue)
                .font(.Micro5.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ColorGridView(colorPalette: palette)
                .padding()
        }
    }
}

//#Preview {
//    CompetitionContentView(competition: MockData.competition)
//        .environmentObject(AppState())
//}
