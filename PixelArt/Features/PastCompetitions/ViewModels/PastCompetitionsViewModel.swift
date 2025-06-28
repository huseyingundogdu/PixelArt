//
//  PastCompetitionsViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/06/2025.
//

import Foundation

final class PastCompetitionsViewModel: ObservableObject {
    
    @Published var state: LoadingState<[Competition]> = .none
    
}
