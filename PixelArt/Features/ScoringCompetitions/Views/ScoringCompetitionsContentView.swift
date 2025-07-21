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
    @State private var currentIndex = 0
    let scoringCompetitions: [Competition]
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            
            informationMessage()
            
            TabView(selection: $currentIndex.animation()) {
                ForEach(scoringCompetitions.indices, id: \.self) { index in
                    let competition = scoringCompetitions[index]
                    VStack(spacing: 5) {
                        Text(competition.topic)
                            .font(.custom("Micro5-Regular", size: 55))
                        
                        Rectangle()
                            .frame(height: 2)
                            .opacity(0.8)
                        
                        Text("\(competition.size[0]) x \(competition.size[1])")
                            .font(.custom("Micro5-Regular", size: 30))
                        
                        TimerView(scoringAt: competition.finishAt)
                        
                        ColorGridView(colorPalette: competition.colorPalette)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                        
                        
                        
                        Button("Score") {

                        }
                        .pixelBackground()
                    }
                    .tag(index)
                    .pixelBackground()
                    .padding(.horizontal)
                    
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 525)
                        
            SquareIndexView(numberOfItems: scoringCompetitions.count, currentIndex: currentIndex)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "d4d4d4"))
    }
    
    private func informationMessage() -> some View {
        VStack(spacing: 20) {
            Text(StringItems.informationMessage.rawValue)
                .font(.custom("Micro5-Regular", size: 30))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
}

#Preview {
    ScoringCompetitionsContentView(scoringCompetitions: [MockData.competition, MockData.competition, MockData.competition])
}

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
