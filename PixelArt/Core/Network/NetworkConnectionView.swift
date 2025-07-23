//
//  NetworkConnectionView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 23/07/2025.
//

import SwiftUI

struct NetworkConnectionView<Content: View>: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    let content: () -> Content
    
    var body: some View {
        Group {
            if networkMonitor.isConnected {
                content()
            } else {
                VStack {
                    Spacer()
                    Text("There is no internet connection.\nPlease connect and try again.")
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}
