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
    @EnvironmentObject var appState: AppState
    @State private var showJoinConfirmation = false
    @StateObject private var joinButtonVM: JoinButtonViewModel
    
    init(competition: Competition) {
        self.competition = competition
        _joinButtonVM = StateObject(wrappedValue: JoinButtonViewModel(competition: competition))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                
                remainingTime(competition.scoringAt)
                competitionTopic(competition.topic)
                colorsOfCompetition(competition.colorPalette)
                
                JoinButtonView(vm: joinButtonVM) {
                    showJoinConfirmation = true
                }
                .foregroundStyle(.black)
                .padding(.horizontal)
                .pixelBackground()
                
            }
            .padding()
            .font(.custom("Micro5-Regular", size: 30))
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "d4d4d4"))
        .overlayAlert(
            isPresented: $showJoinConfirmation,
            title: "Are you sure?",
            confirmText: "Create"
        ) {
            Text("\(competition.size[0]) x \(competition.size[1]) Canvas with \(competition.topic) theme will be created.")
        } onConfirm: {
            // Firestore’a artwork oluştur
            Task {
                await joinButtonVM.joinCompetitionIfNeeded()
            }
        }
        .onAppear {
            if let user = appState.currentUser {
                joinButtonVM.competition = competition
                joinButtonVM.user = user
            }
        }
    }
    
    private func remainingTime(_ scoringAt: Timestamp) -> some View {
        VStack(spacing: 20) {
            Text(StringItems.time.rawValue)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TimerView(scoringAt: scoringAt)
        }
    }
    
    private func competitionTopic(_ topic: String) -> some View {
        VStack(spacing: 20) {
            Text(StringItems.topic.rawValue)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("\"\(topic)\"")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.custom("Micro5-Regular", size: 45))
        }
    }
    
    private func colorsOfCompetition(_ palette: [String]) -> some View {
        VStack(spacing: 20) {
            Text(StringItems.colors.rawValue)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ColorGridView(colorPalette: palette)
                .padding()
        }
    }
}

#Preview {
    CompetitionContentView(competition: MockData.competition)
        .environmentObject(AppState())
}
