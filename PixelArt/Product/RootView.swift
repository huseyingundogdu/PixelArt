//
//  ContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 04/02/2025.
//

import SwiftUI
import FirebaseFirestore


struct RootView: View {
    
    @StateObject var appState = AppState()
    
    var body: some View {
        if appState.isLoggedIn {
            MainTabbedView(appState: appState)
        } else {
            AuthFlowView(appState: appState)
        }
    }
    
}


#Preview {
    RootView()
}
