//
//  ArtworkViewModel.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 03/06/2025.
//

import Foundation

final class ArtworkViewModel: ObservableObject {
    
    @Published var state: LoadingState<[Artwork]> = .none
    

    
    private let repository: ArtworkRepository
    
    init(repository: ArtworkRepository = FirestoreArtworkRepository()) {
        self.repository = repository
    }
    
    func loadCurrentUserArtworks() async {
        state = .loading
        do {
            let artworks = try await repository.fetchArtworks(by: "currentUserId")
            state = .success(artworks)
        } catch {
            state = .error(error)
        }
    }
    
    func retry() {
        Task {
            await loadCurrentUserArtworks()
        }
    }
    
}
