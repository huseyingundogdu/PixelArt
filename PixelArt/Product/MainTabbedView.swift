//
//  MainTabbedView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import SwiftUI

struct MainTabbedView: View {
    @State var selectedTab = 0

    // View'leri bir kere yarat ve sakla
    private let competitionView = CompetitionView()
    private let artworksView = ArtworksView()
    private let profileView = ProfileView()

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                competitionView
                    .tag(0)
                    .toolbarBackground(Color(hex: "3b3b3b"), for: .tabBar)

                artworksView
                    .tag(1)

                profileView
                    .tag(2)
            }

            HStack {
                ForEach(TabbedItems.allCases, id: \.self) { item in
                    Button {
                        selectedTab = item.rawValue
                    } label: {
                        CustomTabItem(
                            imageName: item.iconName,
                            title: item.title,
                            isActive: (selectedTab == item.rawValue)
                        )
                    }
                }
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
            .background(Color(hex: "3b3b3b"))
        }
        .ignoresSafeArea()
        .onChange(of: selectedTab) { _, newValue in
            if newValue == 1 {
                NotificationCenter.default.post(name: .refreshArtworks, object: nil)
            }
        }
    }
}

#Preview {
    MainTabbedView()
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
