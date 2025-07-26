//
//  SignupView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/05/2025.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var appState: AppState
    
    @Binding var path: NavigationPath
    @StateObject private var viewModel: SignupViewModel
    
    init(
        path: Binding<NavigationPath>,
        appState: AppState
    ) {
        _path = path
        _viewModel = StateObject(wrappedValue:SignupViewModel(appState:appState))
    }
    
    var body: some View {
        VStack {
            CustomNavBar(
                title: "Pixel-Art",
                subtitle: "Sign Up",
                leadingButtonIcon: "ic_arrow",
                leadingButtonAction: { path.removeLast() }
            )
            
            VStack {
                Image("ic_crown")
                    .resizable()
                    .interpolation(.none)
                    .frame(width: 100, height: 100)
                    .padding()
                
                
                TextField("Email", text: $viewModel.email)
                    .pixelBackground()
                TextField("Username", text: $viewModel.username)
                    .pixelBackground()
                SecureField("Password", text: $viewModel.password)
                    .pixelBackground()

                
                Text("\(appState.authError ?? "")")
                
                Spacer()
                
                Button("Sign Up") {
                    Task { await viewModel.signUp() }
                }
                .foregroundStyle(.black)
                .pixelBackground()
                .padding(.top)
                
                Button("Already have account") {
                    path.removeLast()
                }
                .foregroundStyle(.black)
            }
            
            .pixelBackground()
            .padding()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "d4d4d4"))
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            appState.authError = nil
        }
    }
}

//#Preview {
//    SignupView(path: .constant(NavigationPath()))
//        .environmentObject(AppState())
//}
