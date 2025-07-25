//
//  TestView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 25/07/2025.
//

import SwiftUI

struct TestView: View {
    
    @State private var isHidden: Bool = false
    
    var body: some View {

            VStack {
                Spacer()
                NavigationStack {
                    
                    NavigationLink {
                        Color.gray
                    } label: {
                        Text("Hello, World!")
                    }
                    .onTapGesture {
                        withAnimation {
                            isHidden = true
                        }
                    }
                    
                }
                Spacer()
                Button {
                    
                } label: {
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: isHidden ? 0 : 100)
                }
            }
        
    }
}

#Preview {
    TestView()
}
