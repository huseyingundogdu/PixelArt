//
//  PastCompetitionsContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/06/2025.
//

import SwiftUI

struct PastCompetitionsContentView: View {
    
    let pastCompetitions: [Competition]
    
    var body: some View {
        Text("Past Competitions")
    }
}

#Preview {
    PastCompetitionsContentView(pastCompetitions: [MockData.competition])
}
