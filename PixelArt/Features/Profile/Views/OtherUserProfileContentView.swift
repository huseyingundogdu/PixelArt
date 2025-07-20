//
//  OtherUserProfileContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 19/07/2025.
//

import SwiftUI

struct OtherUserProfileContentView: View {
    
    let appUser: AppUser
    let archivedArtworks: [Artwork]
    let sharedArtworks: [Artwork]
    
    var body: some View {
        VStack {
            Text("Selected user id: \(appUser.id)")
            Text("Selected user username: \(appUser.username)")
            Text("Selected user email: \(appUser.email)")
            
            Text("Selected user archivedArtworks: \(archivedArtworks.count)")
            Text("Selected user sharedArtworks: \(sharedArtworks.count)")
        }
    }
}

//#Preview {
//    OtherUserProfileContentView()
//}
