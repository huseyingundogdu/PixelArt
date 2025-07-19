//
//  OtherUserProfileView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 19/07/2025.
//

import SwiftUI

struct OtherUserProfileView: View {
    let appState: AppState
    let selectedUserId: String
    @Binding var path: NavigationPath
    @StateObject private var viewModel: OtherUserProfileViewModel
    
    init(
        appState: AppState,
        path: Binding<NavigationPath>,
        selectedUserId: String
    ) {
        self.appState = appState
        _path = path
        self.selectedUserId = selectedUserId
        _viewModel = StateObject(wrappedValue: OtherUserProfileViewModel(appState: appState, selectedUserId: selectedUserId))
    }
    
    var body: some View {
        VStack {
            contentView
        }
        .onAppear {
            Task { await viewModel.load() }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .none, .loading:
            ProgressView("Loading...")
        case .success(let data):
            OtherUserProfileContentView(
                appUser: data.user,
                archivedArtworks: data.archive,
                sharedArtworks: data.shared
            )
        case .error(let error):
            VStack {
                Text("\(error.localizedDescription)")
            }
        }
    }
    
}

//#Preview {
//    OtherUserProfileView()
//}
