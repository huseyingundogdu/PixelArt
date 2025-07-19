//
//  JoinButtonView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 25/06/2025.
//

import SwiftUI

enum JoinButtonState: Equatable {
    case idle
    case loading
    case joined
    case error(String)
}

struct JoinButtonView: View {

    var state: JoinButtonState
    var onTapped: () -> Void
    
    var body: some View {
        Button {
            // Eskiden doğrudan join yapıyorduk
            // Şimdi "Are you sure?" açtırıyoruz:
            onTapped()
        } label: {
            labelView
        }
        .disabled(!isButtonEnabled)
    }
    
    @ViewBuilder
    private var labelView: some View {
        switch state {
        case .idle:
            Text("Join")
                .bold()
        case .loading:
            ProgressView()
        case .joined:
            Text("Already Joined")
                .foregroundColor(.gray)
        case .error(let message):
            VStack {
                Text("Retry Join")
                    .bold()
                Text(message)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
    
    private var isButtonEnabled: Bool {
        switch state {
        case .idle, .error:
            return true
        default:
            return false
        }
    }
}


//#Preview {
//    JoinButtonView()
//}
