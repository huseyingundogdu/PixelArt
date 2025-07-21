//
//  MainTabbedView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import SwiftUI

struct MainTabbedView: View {
    @StateObject private var router: NavigationRouter = NavigationRouter()
    
    let appState: AppState
    @State private var selectedTab: TabbedItems = .artworks
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                NavigationStack(path: $router.competitionRoutes) {
                    CompetitionView(appState: appState)
                        .navigationDestination(for: CompetitionRoutes.self) { route in
                            route.destination(appState: appState)
                        }
                }
                .environmentObject(router)
                .tag(TabbedItems.competition)
                .toolbarBackground(Color(hex: "3b3b3b"), for: .tabBar)
                
                NavigationStack(path: $router.artworksRoutes) {
                    ArtworksView(appState: appState)
                        .navigationDestination(for: ArtworksRoutes.self) { route in
                            
                        }
                }
                .environmentObject(router)
                .tag(TabbedItems.artworks)
                
                NavigationStack(path: $router.profileRoutes) {
                    CurrentUserProfileView(appState: appState)
                        .navigationDestination(for: ProfileRoutes.self) { route in
                            route.destination(appState: appState)
                        }
                }
                .environmentObject(router)
                .tag(TabbedItems.profile)
            }
            
            HStack {
                ForEach(TabbedItems.allCases, id: \.self) { item in
                    Button {
                        if selectedTab == item {
                            withAnimation {
                                router.resetRoute(for: item)
                            }
                        } else {
                            withAnimation {
                                selectedTab = item
                            }
                        }
                    } label: {
                        CustomTabItem(
                            imageName: item.iconName,
                            title: item.title,
                            isActive: (item == selectedTab)
                        )
                    }
                }
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
            .background(Color(hex: "3b3b3b"))
        }
        .ignoresSafeArea()
    }
}


extension MainTabbedView{
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        
        HStack(spacing: 10){
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 25, height: 25)
            if isActive{
                Text(title)
                    .font(.custom("Micro5-Regular", size: 20))
                    .foregroundColor(isActive ? .black : .gray)
            }
            
        }
        .frame(maxWidth: isActive ? .infinity : 30)
        .pixelBackground(paddingValue: 20)
        
    }
}
