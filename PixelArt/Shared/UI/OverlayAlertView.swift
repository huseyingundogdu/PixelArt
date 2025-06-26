//
//  OverlayAlertView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/05/2025.
//

import SwiftUI

struct OverlayAlertView<M: View>: View {
    let title: String
    let message: () -> M
    let confirmText: String
    let onConfirm: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.custom("Micro5-Regular", size: 40))
                .foregroundColor(.black)
            
            message()
                .font(.custom("Micro5-Regular", size: 30))
                .multilineTextAlignment(.center)
            
            HStack {
                Button("Cancel", role: .cancel, action: onCancel)
                    .font(.custom("Micro5-Regular", size: 30))
                    .frame(maxWidth: .infinity)
                    .pixelBackground(paddingValue: 10)
                    .foregroundStyle(Color.init(hex: "ad3636"))
                
                Button(confirmText, action: onConfirm)
                    .font(.custom("Micro5-Regular", size: 30))
                    .frame(maxWidth: .infinity)
                    .pixelBackground(paddingValue: 10)
                    .foregroundStyle(Color.init(hex: "315c2e"))
            }
        }
        .padding()
        .pixelBackground()
        .padding(40)
        .transition(.scale.combined(with: .opacity))
        
    }
}

#Preview {
    OverlayAlertView(
        title: "Are you sure?",
        message: {
            Text("16x16 Canvas with Skull theme will be created.")
        },
        confirmText: "Create") {
            
        } onCancel: {
            
        }

}

/*
 .overlayAlert(
     isPresented: $showJoinConfirmation,
     title: "Are you sure?",
     confirmText: "Create"
 ) {
     Text("\(competition.size) Canvas with \(competition.topic) theme will be created.")
 } onConfirm: {
     // Firestore’a artwork oluştur
 }
 */
