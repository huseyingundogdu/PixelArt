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
            CustomNavBar(
                title: "Profile",
                subtitle: "",
                leadingButtonIcon: nil,
                leadingButtonAction: nil,
                trailingButtonIcon: nil,
                trailingButtonAction: nil
            )
            Spacer()
            
            Text("Profile View")
            
            Text(appState.currentUser?.email ?? "0---0")
            
            Button("Logout") {
                appState.logOut()
            }
            
            Spacer()
            
        }
        .onAppear {
            appState.authError = nil
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppState())
}
