//
//  ScoringCompetitionsViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/06/2025.
//

import Foundation

final class ScoringCompetitionsViewModel: ObservableObject {
    @Published var state: LoadingState<[Competition]> = .none
    
}
