//
//  NavigationRouter.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 21/07/2025.
//

import SwiftUI

final class NavigationRouter: ObservableObject {
    
    @Published var competitionRoutes: [CompetitionRoutes] = []
    @Published var profileRoutes: [ProfileRoutes] = []
    
}
