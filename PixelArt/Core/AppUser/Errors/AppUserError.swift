//
//  AppUserError.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 18/07/2025.
//

import Foundation

enum AppUserError: Error, LocalizedError {
    case unauthorized
    case notFound
    case invalidData
    case unknown
    case invalidUsername
    
    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "You are not authorized to perform this action."
        case .notFound:
            return "The user could not be found."
        case .invalidData:
            return "The provided user data is invalid."
        case .unknown:
            return "An unknown error occured."
        case .invalidUsername:
            return "The username is invalid. Please choose a non-empty username."
        }
    }
}
