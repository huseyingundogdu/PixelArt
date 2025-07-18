//
//  PastCompetitionsContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/06/2025.
//

import SwiftUI

struct PastCompetitionsContentView: View {
    @Binding var path: NavigationPath
    let pastCompetitions: [Competition]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(pastCompetitions, id: \.self) { competition in
                    RowView(competition: competition)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .pixelBackground()
                        .onTapGesture { path.append(CompetitionTo.result(competition)) }
                }
            }
            .padding()
        }
        .font(.custom("Micro5-Regular", size: 25))
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "d4d4d4"))
    }
}

#Preview {
    PastCompetitionsContentView(path: .constant(NavigationPath()),pastCompetitions: [MockData.competition, MockData.competition, MockData.competition])
}


private struct RowView: View {
    let competition: Competition
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(competition.topic) - \(competition.size[0])x\(competition.size[1])")
                    .font(.custom("Micro5-Regular", size: 40))
                Text("\(competition.activatedAt.dateValue().formatted(date: .abbreviated, time: .complete))")
            }
            Spacer()
            Image("ic_chevron")
                .interpolation(.none)
                .scaleEffect(CGSize(width: 2.0, height: 2.0))
        }
    }
}
