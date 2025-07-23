//
//  ContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 04/02/2025.
//

import SwiftUI
import FirebaseFirestore


struct RootView: View {
    @StateObject private var appState = AppState()
    @StateObject private var networkMonitor = NetworkMonitor.shared
    
    var body: some View {
        if appState.isLoggedIn {
            MainTabbedView(appState: appState)
                .environmentObject(networkMonitor)
        } else {
            AuthFlowView(appState: appState)
        }
    }
    
}


#Preview {
    RootView()
}
