//
//  StringArrayTransformer.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 24/07/2025.
//

import Foundation

@objc(StringArrayTransformer)
final class StringArrayTransformer: ValueTransformer {
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let array = value as? [String] else { return nil }
        do {
            let data = try JSONEncoder().encode(array)
            return data
        } catch {
            print("Encoding error: \(error)")
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        do {
            let array = try JSONDecoder().decode([String].self, from: data)
            return array
        } catch {
            print("Decoding error: \(error)")
            return nil
        }
    }
    
    override class func allowsReverseTransformation() -> Bool {
        true
    }
    
    override class func transformedValueClass() -> AnyClass {
        NSData.self
    }
}

