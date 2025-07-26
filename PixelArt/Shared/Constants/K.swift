//
//  K.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 22/07/2025.
//

import Foundation

struct K {
    
    
    struct Artwork {
        struct Size {
            static let profile: CGSize = CGSize(width: 150, height: 150)
            static let regular: CGSize = CGSize(width: 100, height: 100)
            static let small: CGSize = CGSize(width: 75, height: 75)
        }
        
        struct Grid {
            static let profileColumns: Int = 33
            static let profileRows: Int = 33
        }
    }
}
