//
//  AppRoute.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 21/07/2025.
//

import SwiftUI

enum Route: Hashable {
    case competition(CompetitionRoutes)
    case artworks(ArtworksRoutes)
    case profile(ProfileRoutes)
    
    @ViewBuilder
    func destination(appState: AppState) -> some View {
        switch self {
        case .competition(let route):
            route.destination(appState: appState)
        case .profile(let route):
            route.destination(appState: appState)
        }
    }
}
