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
        ScrollView {
            ForEach(pastCompetitions, id: \.self) { competition in
                VStack {
                    Text("id: \(competition.id)")
                    Text("topic: \(competition.topic)")
                    Text("size: \(competition.size[0]) x \(competition.size[1])")
                    Text("status: \(competition.status)")
                }
            }
        }
    }
}

#Preview {
    PastCompetitionsContentView(pastCompetitions: [MockData.competition])
}
