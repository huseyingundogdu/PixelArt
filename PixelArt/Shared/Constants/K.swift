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
            static let profile: CGSize = CGSize(width: 200, height: 200)
            static let regular: CGSize = CGSize(width: 150, height: 125)
            static let small: CGSize = CGSize(width: 80, height: 80)
        }
        
        struct Grid {
            static let profileColumns: Int = 33
            static let profileRows: Int = 33
        }
    }
}
