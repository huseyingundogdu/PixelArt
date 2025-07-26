//
//  PastCompetitionsContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/06/2025.
//

import SwiftUI

struct PastCompetitionsContentView: View {
    @EnvironmentObject private var router: NavigationRouter

    let pastCompetitions: [Competition]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(pastCompetitions, id: \.self) { competition in
                    RowView(competition: competition)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .pixelBackground()
                        .onTapGesture { 
                            router.competitionRoutes.append(.result(competition: competition))
                        }
                }
            }
            .padding()
        }
        
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "d4d4d4"))
    }
}

#Preview {
    PastCompetitionsContentView(pastCompetitions: [MockData.competition, MockData.competition, MockData.competition])
}


private struct RowView: View {
    let competition: Competition
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(competition.topic) - \(competition.size[0])x\(competition.size[1])")
                    .font(.Micro5.medium)
                    
                Text("\(competition.activatedAt.dateValue().formatted(date: .abbreviated, time: .omitted))")
            }
            Spacer()
            Image("ic_chevron")
                .interpolation(.none)
                .scaleEffect(CGSize(width: 2.0, height: 2.0))
        }
    }
}
