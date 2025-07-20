//
//  UserListView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/07/2025.
//

import SwiftUI

struct UserListView: View {
    let appState: AppState
    @Binding var path: NavigationPath
    @StateObject private var viewModel: UserListViewModel
    
    let usersIds: [String]
    let title: String
    let subtitle: String

    init(
        appState: AppState,
        path: Binding<NavigationPath>,
        usersIds: [String],
        title: String,
        subtitle: String
    ) {
        self.appState = appState
        _path = path
        _viewModel = StateObject(wrappedValue: UserListViewModel(appState: appState, idArr: usersIds))
        self.usersIds = usersIds
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(
                title: title,
                subtitle: subtitle,
                leadingButtonIcon: "ic_arrow",
                leadingButtonAction: {
                    path.removeLast()
                }
            )
            
            contentView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            Task { await viewModel.loadAppUsers() }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .none, .loading:
            ProgressView("Loading...")
        case .success(let appUsers):
            
            UserListContentView(path: $path, appUsers: appUsers)
            
        case .error(let error):
            VStack {
                Text("Error: \(error.localizedDescription)")
                
                Button("Try Again") {
                    Task { await viewModel.retry() }
                }
            }
        }
    }
}

//#Preview {
//    UserListView(path: .constant(NavigationPath()))
//}
