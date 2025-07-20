//
//  UserListContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 20/07/2025.
//

import SwiftUI

struct UserListContentView: View {
    @Binding var path: NavigationPath
    let appUsers: [AppUser]
    
    var body: some View {
        ScrollView {
            ForEach(appUsers) { user in
                Button {
                    path.append(ProfileTo.otherUserProfile(user.id))
                } label: {
                    HStack {
                        //FIXME: ArtoworkViewer will change to Profile Picture Viewer fixed size 64x64
                        ArtworkViewer(artwork: Artwork(
                            id: "",
                            authorId: "",
                            authorUsername: "",
                            data: user.profilePictureData,
                            competitionId: nil,
                            size: [2, 2],
                            status: .personal),
                                      viewSize: 50,
                                      isFullScreenAvailable: false
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
        path: .constant(NavigationPath()),
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
    ])
}
