//
//  UserListView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/07/2025.
//

import SwiftUI

struct UserListView: View {
    @EnvironmentObject private var router: NavigationRouter
    
    let appState: AppState
    @StateObject private var viewModel: UserListViewModel
    
    let usersIds: [String]
    let title: String
    let subtitle: String
    let context: RouteContext
    
    init(
        appState: AppState,
        usersIds: [String],
        title: String,
        subtitle: String,
        context: RouteContext
    ) {
        self.appState = appState
        _viewModel = StateObject(wrappedValue: UserListViewModel(appState: appState, idArr: usersIds))
        self.usersIds = usersIds
        self.title = title
        self.subtitle = subtitle
        self.context = context
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(
                title: title,
                subtitle: subtitle,
                leadingButtonIcon: "ic_arrow",
                leadingButtonAction: {
                    switch context {
                    case .competition:
                        router.competitionRoutes.removeLast()
                    case .profile:
                        router.profileRoutes.removeLast()
                    }
                }
            )
            
            contentView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color(hex: "d4d4d4"))
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
            
            UserListContentView(appUsers: appUsers, context: context)
            
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

