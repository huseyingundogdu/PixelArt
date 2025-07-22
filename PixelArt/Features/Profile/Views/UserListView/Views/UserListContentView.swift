//
//  UserListContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/07/2025.
//

import SwiftUI

struct UserListContentView: View {
    @EnvironmentObject private var router: NavigationRouter
    
    let appUsers: [AppUser]
    let context: RouteContext
    
    var body: some View {
        ScrollView {
            ForEach(appUsers) { user in
                Button {
                    switch context {
                    case .competition:
                        router.competitionRoutes.append(.userProfile(userId: user.id))
                    case .profile:
                        router.profileRoutes.append(.userProfile(userId: user.id))
                    }

                } label: {
                    HStack {
                        //FIXME: ArtoworkViewer will change to Profile Picture Viewer fixed size 64x64
                        PixelGridView(
                            data: user.profilePictureData,
                            columns: K.Artwork.Grid.profileColumns,
                            rows: K.Artwork.Grid.profileRows,
                            availableWidth: K.Artwork.Size.small.width,
                            availableHeight: K.Artwork.Size.small.height
                        )
                        
                        
                        Text(user.username)
                            .font(.custom("Micro5-Regular", size: 25))
                        Spacer()
                    }
                    
                    .frame(maxWidth: .infinity)
                    //                .padding()
                    .pixelBackground(paddingValue: 10)
                    .padding(.horizontal)
                }
                .foregroundStyle(.black)
            }
            .padding()
        }
    }
}

#Preview {
    UserListContentView(
        appUsers: [
        AppUser(
            id: "user-id-1",
            email: "user-1@gmail.com",
            username: "user-1",
            profilePictureData: ["#A18276", "#B9D2B1", "#DAC6B5", "#F1D6B8"],
            followers: [],
            following: [],
            joinedCompetitions: [],
            createdAt: .now
        ),
        AppUser(
            id: "user-id-2",
            email: "user-2@gmail.com",
            username: "user-2",
            profilePictureData: ["#1E1E24", "#92140C", "#FFF8F0", "#FFCF99"],
            followers: [],
            following: [],
            joinedCompetitions: [],
            createdAt: .now
        ),
        AppUser(
            id: "user-id-3",
            email: "user-3@gmail.com",
            username: "user-3",
            profilePictureData: ["#FFA9E7", "#414361", "#7F2CCB", "#2A2D43"],
            followers: [],
            following: [],
            joinedCompetitions: [],
            createdAt: .now
        )
    ],
        context: .competition
    )
}
