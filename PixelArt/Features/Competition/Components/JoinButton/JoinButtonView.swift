//
//  JoinButtonView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 25/06/2025.
//

import SwiftUI

struct JoinButtonView: View {
    
    @ObservedObject var vm: JoinButtonViewModel

    var onRequestJoin: () -> Void
    
    var body: some View {
        Button {
            // Eskiden doğrudan join yapıyorduk
            // Şimdi "Are you sure?" açtırıyoruz:
            onRequestJoin()
        } label: {
            labelView
        }
        .disabled(!isButtonEnabled)
        .task {
            await vm.checkIfUserAlreadyJoined()
        }
    }
    
    @ViewBuilder
    private var labelView: some View {
        switch vm.state {
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
        switch vm.state {
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
