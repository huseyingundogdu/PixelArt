//
//  NavigationRouter.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 21/07/2025.
//

import SwiftUI

enum RouteContext {
    case competition
    case profile
}

final class NavigationRouter: ObservableObject {
    
    @Published var competitionRoutes: [CompetitionRoutes] = []
    @Published var profileRoutes: [ProfileRoutes] = []
    
    
    func resetRoute(for tab: TabbedItems) {
        switch tab {
        case .competition:
            competitionRoutes.removeAll()
        case .artworks:
            break
        case .profile:
            profileRoutes.removeAll()
        }
    }
}
