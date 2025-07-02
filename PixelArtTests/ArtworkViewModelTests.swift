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
    
    func test_loadUserArtworks_shouldHandleError() async {
        // Arrange
        let mockRepo = MockArtworkRepository()
        mockRepo.shouldThrowError = true
        
        let viewModel = ArtworkViewModel(repository: mockRepo, userId: "user123")
        
        // Act
        await viewModel.loadUserArtworks()
        
        // Assert
        XCTAssertNotNil(viewModel.error)
        XCTAssertTrue(viewModel.personalArtworks.isEmpty)
        XCTAssertTrue(viewModel.sharedArtworks.isEmpty)
        XCTAssertTrue(viewModel.activeCompetitionArtworks.isEmpty)
        XCTAssertTrue(viewModel.archivedArtworks.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func test_loadUserArtworks_shouldPopulateAllCategories() async {
        // Arrange
        let mockRepo = MockArtworkRepository()
        mockRepo.shouldThrowError = false
        
        mockRepo.personalArtworksShouldReturn = [
            Artwork(
                id: "personal1",
                authorId: "user123",
                data: ["#000000"],
                competitionId: nil,
                size: [16, 16],
                topic: "Personal",
                status: .personal
            )
        ]
        
        mockRepo.sharedArtworksShouldReturn = [
            Artwork(
                id: "shared1",
                authorId: "user123",
                data: ["#111111"],
                competitionId: nil,
                size: [16, 16],
                topic: "Shared",
                status: .shared
            )
        ]
        
        mockRepo.activeCompetitionArtworksShouldReturn = [
            Artwork(
                id: "active1",
                authorId: "user123",
                data: ["#222222"],
                competitionId: "competition1",
                size: [16, 16],
                topic: "Competition",
                status: .personal
            )
        ]
        
        mockRepo.archivedArtworksShouldReturn = [
            Artwork(
                id: "archived1",
                authorId: "user123",
                data: ["#333333"],
                competitionId: "competition2",
                size: [16, 16],
                topic: "Archived",
                status: .archived
            )
        ]
        
        let viewModel = ArtworkViewModel(repository: mockRepo, userId: "user123")
        
        await viewModel.loadUserArtworks()
        
        XCTAssertEqual(viewModel.personalArtworks.count, 1)
        XCTAssertEqual(viewModel.sharedArtworks.count, 1)
        XCTAssertEqual(viewModel.activeCompetitionArtworks.count, 1)
        XCTAssertEqual(viewModel.archivedArtworks.count, 1)
        
        XCTAssertEqual(viewModel.personalArtworks.first?.id, "personal1")
        XCTAssertEqual(viewModel.sharedArtworks.first?.id, "shared1")
        XCTAssertEqual(viewModel.activeCompetitionArtworks.first?.id, "active1")
        XCTAssertEqual(viewModel.archivedArtworks.first?.id, "archived1")
        
        XCTAssertNil(viewModel.error)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func test_loadUserArtworks_shouldSetIsLoadingProperly() async {
        // Arrange
        let mockRepo = MockArtworkRepository()
        mockRepo.personalArtworksShouldReturn = []
        mockRepo.sharedArtworksShouldReturn = []
        mockRepo.activeCompetitionArtworksShouldReturn = []
        mockRepo.archivedArtworksShouldReturn = []
        
        let viewModel = ArtworkViewModel(repository: mockRepo, userId: "user123")
        
        // Act
        await viewModel.loadUserArtworks()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after loading completes")
    }
    
    func test_retry_shouldCallLoadUserArtworks() async {
        //Arrange
        let mockRepo = MockArtworkRepository()
        
        mockRepo.personalArtworksShouldReturn = [
            Artwork(
                id: "personal1",
                authorId: "user123",
                data: ["#000000"],
                competitionId: nil,
                size: [16, 16],
                topic: nil,
                status: .personal
            )
        ]
        
        mockRepo.shouldThrowError = true
        
        let viewModel = ArtworkViewModel(repository: mockRepo, userId: "user123")
        
        
        //Act1 - will throw an error
        await viewModel.loadUserArtworks()
        
        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.personalArtworks.count, 0)
        XCTAssertEqual(viewModel.sharedArtworks.count, 0)
        XCTAssertEqual(viewModel.activeCompetitionArtworks.count, 0)
        XCTAssertEqual(viewModel.archivedArtworks.count, 0)
        XCTAssertFalse(viewModel.isLoading)
        
        //Arrange
        mockRepo.shouldThrowError = false
        
        //Act2 - retry and it will be succeed
        await viewModel.retry()
        
        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.personalArtworks.count, 1)
        XCTAssertEqual(viewModel.sharedArtworks.count, 0)
        XCTAssertEqual(viewModel.activeCompetitionArtworks.count, 0)
        XCTAssertEqual(viewModel.archivedArtworks.count, 0)
        XCTAssertFalse(viewModel.isLoading)
    }
    
}
