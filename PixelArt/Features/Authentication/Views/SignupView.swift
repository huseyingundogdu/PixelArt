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

    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    
    
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
                
                
                TextField("Email", text: $email)
                    .pixelBackground()
                TextField("Username", text: $username)
                    .pixelBackground()
                SecureField("Password", text: $password)
                    .pixelBackground()
//                SecureField("Password Again", text: $validationPassword)
//                    .pixelBackground()
                
                Text("\(appState.authError ?? "")")
                
                Spacer()
                
                Button("Sign Up") {
                    Task { await appState.register(email: email, username: username, password: password) }
                }
                .foregroundStyle(.black)
                .pixelBackground()
                .padding(.top)
                
                Button("Already have account") {
                    path.removeLast()
                }
                .foregroundStyle(.black)
            }
            .font(.custom("Micro5-Regular", size: 30))
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

#Preview {
    SignupView(path: .constant(NavigationPath()))
        .environmentObject(AppState())
}
