//
//  ArtworkViewModelTests.swift
//  PixelArtTests
//
//  Created by Hüseyin Gündoğdu on 02/07/2025.
//

import XCTest
@testable import PixelArt

final class ArtworkViewModelTests: XCTestCase {
    
    func test_initialState_shouldBeEmpty() {
        let viewModel = ArtworkViewModel()
        
        XCTAssertEqual(viewModel.personalArtworks.count, 0)
        XCTAssertEqual(viewModel.activeCompetitionArtworks.count, 0)
        XCTAssertEqual(viewModel.sharedArtworks.count, 0)
        XCTAssertEqual(viewModel.archivedArtworks.count, 0)
        XCTAssertNil(viewModel.error)
        XCTAssertFalse(viewModel.isLoading)
    }
    
}
