//
//  CompetitionView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import SwiftUI
import FirebaseFirestore
import FirebaseCore


struct CompetitionView: View {
    
    @StateObject private var viewModel = CompetitionViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            /*
            CustomNavBar(
                title: "Competition",
                trailingButtonIcon: "ic_crown",
                trailingButtonAction: {
                    print("Crown tapped")
                }
            )
            */
            
            CustomNavBar(
                title: "Competition",
                leadingButtonIcon: "ic_comp",
                leadingButtonAction: {
                    print("comp tapped")
                },
                trailingButtonIcon: "ic_crown") {
                    print("crown tapped")
                }
            
            
            contentView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hex: "d4d4d4"))
        }
//        .ignoresSafeArea(edges: .top) // Eğer nav bar tam tepeye oturmalıysa
        .onAppear {
            if case .none = viewModel.state {
                viewModel.retry()
            }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .none, .loading:
            ProgressView("Loading...")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .font(.custom("Micro5-Regular", size: 32))
        case .success(let competition):
            
            CompetitionContentView(competition: competition, currentUserId: "currentUserId")
            
        case .error(let error):
            VStack(spacing: 16) {
                Text("\(error.localizedDescription)")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.red)
                Button("Try Again") {
                    viewModel.retry()
                }
                .pixelBackground(paddingValue: 12)
            }
            .font(.custom("Micro5-Regular", size: 32))
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding()
        }
    }
}

#Preview {
    CompetitionView()
}
