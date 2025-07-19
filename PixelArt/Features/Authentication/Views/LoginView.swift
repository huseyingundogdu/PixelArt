//
//  LoginViewm.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/05/2025.
//

import SwiftUI

struct LoginView: View {
    let appState: AppState
    @Binding var path: NavigationPath
    @StateObject private var viewModel: LoginViewModel
    
    init(
        appState: AppState,
        path: Binding<NavigationPath>
    ) {
        self.appState = appState
        _path = path
        _viewModel = StateObject(wrappedValue: LoginViewModel(appState:appState))
    }
    
    var body: some View {
        VStack {
            Image("ic_crown")
                .resizable()
                .interpolation(.none)
                .frame(width: 100, height: 100)
                .padding()
                
            
            TextField("Email", text: $viewModel.email)
                .pixelBackground()
            SecureField("Password", text: $viewModel.password)
                .pixelBackground()
            
            if let error = viewModel.authError {
                Text("\(error)")
            }
            
            Spacer()
            
            Button {
                Task { await viewModel.login() }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(width: 200)
                } else {
                    Text("Login")
                        .frame(width: 200)
                }
            }
            .foregroundStyle(.black)
            .pixelBackground()
            .padding(.top)
            
            Button("Create account") {
                path.append(AuthFlowViewPath.signUp)
            }
            .foregroundStyle(.black)
        }
        .font(.custom("Micro5-Regular", size: 30))
        .pixelBackground()
        .padding()
    }
}

//#Preview {
//    LoginView(appState: .constant(NavigationPath()))
//        .background(Color(hex: "d4d4d4"))
//}

