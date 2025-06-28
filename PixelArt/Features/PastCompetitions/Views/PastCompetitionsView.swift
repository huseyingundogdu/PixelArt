//
//  PastCompetitionsView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 28/06/2025.
//

import SwiftUI

struct PastCompetitionsView: View {
    
    @StateObject private var viewModel = PastCompetitionsViewModel()
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(
                title: "Past Competitions",
                leadingButtonIcon: "ic_arrow",
                leadingButtonAction: {
                    path.removeLast()
                }
            )
            
            contentView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hex: "d4d4d4"))
        }
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .none, .loading:
            ProgressView("Loading past competitions...")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .font(.custom("Micro5-Regular", size: 32))
        case .success(let pastCompetitions):
            PastCompetitionsContentView(pastCompetitions: pastCompetitions)
        case .error(let error):
            VStack(spacing: 16) {
                Text("\(error.localizedDescription)")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.red)
                Button("Try Again") {
                    
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
    PastCompetitionsView(path: .constant(NavigationPath()))
}
