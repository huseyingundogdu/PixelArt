//
//  AuthFlowView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/05/2025.
//

import SwiftUI


struct AuthFlowView: View {
    let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomNavBar(title: "PixelArt", subtitle: "Login")
                LoginView(appState: appState)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color(hex: "d4d4d4"))
        }
    }
}

//#Preview {
//    AuthFlowView()
//        .environmentObject(AppState())
//}
