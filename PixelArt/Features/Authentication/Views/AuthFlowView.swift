//
//  AuthFlowView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/05/2025.
//

import SwiftUI

enum AuthFlowViewPath: Hashable {
    case signUp
}

struct AuthFlowView: View {
    let appState: AppState
    @State private var path: NavigationPath = NavigationPath()
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                CustomNavBar(title: "PixelArt", subtitle: "Login")
                LoginView(
                    appState: appState,
                    path: $path
                )
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color(hex: "d4d4d4"))
            .navigationDestination(for: AuthFlowViewPath.self) { destination in
                switch destination {
                case .signUp:
                    SignupView(
                        path: $path,
                        appState: appState
                    )
                }
            }
        }
    }
}

//#Preview {
//    AuthFlowView()
//        .environmentObject(AppState())
//}
