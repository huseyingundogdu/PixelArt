//
//  LoginViewm.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/05/2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @Binding var path: NavigationPath
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Image("ic_crown")
                .resizable()
                .interpolation(.none)
                .frame(width: 100, height: 100)
                .padding()
                
            
            TextField("Email", text: $email)
                .pixelBackground()
            SecureField("Password", text: $password)
                .pixelBackground()
            
            Text("\(appState.authError ?? "")")
            
            Spacer()
            
            Button {
                Task { await appState.login(email: email, password: password) }
            } label: {
                if appState.isLoading {
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
        .onAppear {
            appState.authError = nil
        }
    }
}

//#Preview {
//    LoginView(appState: .constant(NavigationPath()))
//        .background(Color(hex: "d4d4d4"))
//}

