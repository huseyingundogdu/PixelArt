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
    
    func test_loadUserArtworks_shouldPopulateOnlyPersonalArtworks() async {
        // Arrange
        let mockRepo = MockArtworkRepository()
        mockRepo.personalArtworksShouldReturn = [
            Artwork(
                id: "test123",
                authorId: "user123",
                data: ["#000000"],
                competitionId: nil,
                size: [16, 16],
                topic: "Sample",
                status: .personal
            )
        ]
        
        mockRepo.activeCompetitionArtworksShouldReturn = []
        mockRepo.archivedArtworksShouldReturn = []
        mockRepo.sharedArtworksShouldReturn = []
        
        let viewModel = ArtworkViewModel(repository: mockRepo)
        
        // Act
        await viewModel.loadUserArtworks()
        
        // Assert
        XCTAssertEqual(viewModel.personalArtworks.count, 1)
        XCTAssertEqual(viewModel.activeCompetitionArtworks.count, 0)
        XCTAssertEqual(viewModel.archivedArtworks.count, 0)
        XCTAssertEqual(viewModel.sharedArtworks.count, 0)
        XCTAssertEqual(viewModel.personalArtworks.first?.id, "test123")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
    }
}
