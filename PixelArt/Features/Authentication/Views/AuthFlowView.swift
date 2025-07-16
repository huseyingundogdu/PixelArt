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
    @EnvironmentObject var appState: AppState
    @State private var path: NavigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                CustomNavBar(title: "PixelArt", subtitle: "Login")
                LoginView(path: $path)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color(hex: "d4d4d4"))
            .navigationDestination(for: AuthFlowViewPath.self) { destination in
                switch destination {
                case .signUp:
                    SignupView(path: $path)
                }
            }
        }
    }
}

#Preview {
    AuthFlowView()
}
