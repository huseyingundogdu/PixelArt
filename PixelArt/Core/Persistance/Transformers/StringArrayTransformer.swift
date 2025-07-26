//
//  StringArrayTransformer.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 24/07/2025.
//

import Foundation

@objc(StringArrayTransformer)
final class StringArrayTransformer: NSSecureUnarchiveFromDataTransformer {

    override class var allowedTopLevelClasses: [AnyClass] {
        return [NSArray.self, NSString.self]
    }

    static func register() {
        let transformer = StringArrayTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: NSValueTransformerName("StringArrayTransformer"))
    }
}



