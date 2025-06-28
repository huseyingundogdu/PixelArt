//
//  ScoringCompetitionsContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/06/2025.
//

import SwiftUI

struct ScoringCompetitionsContentView: View {

    let scoringCompetitions: [Competition]
    
    var body: some View {
        Text("Scoring Competitions")
    }
}

#Preview {
    ScoringCompetitionsContentView(scoringCompetitions: [MockData.competition])
}
