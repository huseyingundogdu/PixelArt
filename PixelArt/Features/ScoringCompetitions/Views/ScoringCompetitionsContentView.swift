//
//  ScoringCompetitionsContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/06/2025.
//

import SwiftUI

private enum StringItems: String {
    case informationMessage = "Select competition to see artworks"
}

struct ScoringCompetitionsContentView: View {
    @EnvironmentObject private var router: NavigationRouter
    
    @State private var currentIndex = 0
    let scoringCompetitions: [CompetitionWithLikeRights]
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            Text(StringItems.informationMessage.rawValue)
                .font(.Micro5.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            TabView(selection: $currentIndex.animation()) {
                ForEach(scoringCompetitions.indices, id: \.self) { index in
                    let item = scoringCompetitions[index]
                    let competition = item.competition
                    let rights = item.likeRights
                    
                    VStack(spacing: 5) {
                        Text(competition.topic)
                            .font(.Micro5.xxLarge)
                        
                        Rectangle()
                            .frame(height: 2)
                            .opacity(0.8)
                        
                        Text("\(competition.size[0]) x \(competition.size[1])")
                            .font(.Micro5.medium)
                        
                        
                        TimerView(scoringAt: competition.finishAt)
                        
                        ColorGridView(colorPalette: competition.colorPalette)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                        
                        
                        
                        Button {
                            router.competitionRoutes.append(.voting(competition: competition))
                        } label: {
                            if let rights {
                                Text("\(rights.used) / \(rights.total)" )
                            } else {
                                Text("See Artworks")
                            }
                        }
                        .font(.Micro5.large)
                        .pixelBackground()
                        .foregroundStyle(.black)
                    }
                    .tag(index)
                    .pixelBackground()
                    .padding(.horizontal)
                    .padding(.top)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .padding(.vertical, 0)
//            .frame(height: 525)
            
            SquareIndexView(numberOfItems: scoringCompetitions.count, currentIndex: currentIndex)
                .padding(.bottom)


        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "d4d4d4"))
    }
}

//#Preview {
//    ScoringCompetitionsContentView(scoringCompetitions: [MockData.competition, MockData.competition, MockData.competition])
//}

struct SquareIndexView: View {
    
    // MARK: - Public Properties
    
    let numberOfItems: Int
    let currentIndex: Int
    
    // MARK: - Drawing Constants
    
    private let squareSize: CGFloat = 20
    private let spacing: CGFloat = 20
    
    private let primaryColor = Color(hex: "3b3b3b")
    private let secondaryColor = Color(hex: "d4d4d4")
    private let smallScale: CGFloat = 0.6
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<numberOfItems) { index in
                if shouldShowIndex(index) {
                    Color.init(currentIndex == index ? primaryColor : secondaryColor)
                        .frame(width: squareSize, height: squareSize)
                        .pixelBackground(paddingValue: 0)
                        .scaleEffect(currentIndex == index ? 1 : smallScale)
                        .transition(AnyTransition.opacity.combined(with: .scale))
                        .id(index)
                }
            }
            .scaleEffect(0.6)
        }
    }
    
    
    // MARK: - Private Methods
    func shouldShowIndex(_ index: Int) -> Bool {
        ((currentIndex - 1)...(currentIndex + 1)).contains(index)
    }
}
