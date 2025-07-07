//
//  ProfileView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel: ProfileViewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            Text("Profile View")
            
            Text(appState.currentUser?.email ?? "0---0")
            
            Button("Logout") {
                appState.logOut()
            }
        }
        .onAppear {
            appState.authError = nil
        }
    }
}

#Preview {
    ProfileView()
}
