//
//  TabbedItems.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import Foundation

enum TabbedItems: Int, CaseIterable{
    case competition = 0
    case artworks
    case profile
    
    var title: String{
        switch self {
        case .competition:
            return "Competition"
        case .artworks:
            return "Artworks"
        case .profile:
            return "Profile"
        }
    }
    
    var iconName: String{
        switch self {
        case .competition:
            return "ic_cmp"
        case .artworks:
            return "ic_art"
        case .profile:
            return "ic_person"
        }
    }
}
