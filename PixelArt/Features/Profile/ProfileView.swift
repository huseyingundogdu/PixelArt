//
//  ProfileView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Text("Profile View")
            
            Button("Logout") {
                appState.isLoggedIn = false
            }
        }
    }
}

#Preview {
    ProfileView()
}
