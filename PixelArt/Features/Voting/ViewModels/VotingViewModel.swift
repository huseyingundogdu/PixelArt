//
//  VotingViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 29/06/2025.
//

import Foundation

final class VotingViewModel: ObservableObject {
    @Published var state: LoadingState<[Artwork]> = .none    
}
