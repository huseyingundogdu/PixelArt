//
//  ProfileContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 16/07/2025.
//

import SwiftUI
import FirebaseAuth

struct ProfileContentView: View {
    @EnvironmentObject private var router: NavigationRouter
    
    @State private var selectedIndex: Int = 0
    
    let user: AppUser
    let archived: [Artwork]
    let shared: [Artwork]
    let context: RouteContext
    
    let showFollowButton: Bool
    @Binding var isFollowing: Bool?
    let onFollowTapped: (() -> Void)?
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .center) {
                    PixelGridView(
                        data: user.profilePictureData,
                        columns: K.Artwork.Grid.profileColumns,
                        rows: K.Artwork.Grid.profileRows,
                        availableWidth: K.Artwork.Size.profile.width,
                        availableHeight: K.Artwork.Size.profile.height
                    )
                    
                    VStack(spacing: 20) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text(user.username)
                                    .font(.Micro5.medium)
                                Text(user.email)
                                    .foregroundStyle(.gray)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            if showFollowButton {
                                if let isFollowing {
                                    Button(isFollowing ? "Unfollow" : "Follow") {
                                        onFollowTapped?()
                                    }
                                } else {
                                    ProgressView()
                                }
                            }
                        }
                        
                        
                        HStack {
                            Button {
                                switch context {
                                case .competition:
                                    router.competitionRoutes.append(.follower(username: user.username, followerIds: user.followers))
                                case .profile:
                                    router.profileRoutes.append(.follower(username: user.username, followerIds: user.followers))
                                }
                            } label: {
                                Text("\(user.followers.count)")
                                Text("Followers")
                                    .foregroundStyle(.gray)
                            }
                            .foregroundStyle(.black)

                            Button {
                                switch context {
                                case .competition:
                                    router.competitionRoutes.append(.following(username: user.username, followingIds: user.following))
                                case .profile:
                                    router.profileRoutes.append(.following(username: user.username, followingIds: user.following))
                                }
                            } label: {
                                Text("\(user.following.count)")
                                Text("Following")
                                    .foregroundStyle(.gray)
                            }
                            .foregroundStyle(.black)

                            Spacer()
                        }
                        
                        
                    }
                }
                
                Rectangle()
                    .frame(height: 3)
                
                VStack(spacing: 10) {
                    Text("Gallery of \(user.username)")
                        .font(.Micro5.xLarge)
                        
                    
                    CustomSegmentedControl(
                        options: ["Competition", "Shared"],
                        selectedIndex: $selectedIndex
                    )
                    
                    Rectangle()
                        .frame(height: 3)
                    
                    if selectedIndex == 0 {
                        VStack(spacing: 10) {
                            ForEach(archived, id: \.self) { artwork in
                                galleryRow(isCompetition: true, artwork: artwork)
                            }
                        }
                    } else {
                        VStack(spacing: 10) {
                            ForEach(shared, id: \.self) { artwork in
                                galleryRow(isCompetition: false, artwork: artwork)
                            }
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
    }
}

extension ProfileContentView {
    private func galleryRow(isCompetition: Bool, artwork: Artwork) -> some View {
        HStack(alignment: .center) {
            
            PixelGridView(
                data: artwork.data,
                columns: artwork.size[0],
                rows: artwork.size[1],
                availableWidth: K.Artwork.Size.regular.width,
                availableHeight: K.Artwork.Size.regular.height
            )
            
            
            VStack(alignment: .leading) {
                
                Text("\(artwork.topic)")
                    .font(.Micro5.medium)
                
                if let compId = artwork.competitionId {
                    Button {
                        //router.profileRoutes.append(.result(competition: artwork.competitionId)) //FIXME: - Add needed route
                    } label: {
                        Text("\(compId)")
                    }
                    .foregroundStyle(.black)
                }
                
                Text("Size: \(artwork.size[0]) x \(artwork.size[1])")
                    .foregroundStyle(.gray)
                
                Spacer()
                if isCompetition {
                    HStack {
                        Spacer()
                        Text("25")
                        Image("ic_heart_fill")
                            .resizable()
                            .interpolation(.none)
                            .frame(width: 20, height: 20)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
        }
        .background(Color(hex:"d4d4d4"))
        .pixelBackground(paddingValue: 10)
    }
}


struct CustomSegmentedControl: View {
    var options: [String]
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(options.indices, id: \.self) { index in
                ZStack {
                    Text(options[index])
                        .frame(maxWidth: .infinity)
                        .pixelBackground(paddingValue: 10)
                        .foregroundStyle(selectedIndex == index ? .black : .gray)
                    
                    Rectangle()
                        .padding(2)
                        .opacity(selectedIndex == index ? 0.0 : 0.4)
                }
                .scaleEffect(selectedIndex == index ? 1 : 0.85)
                .onTapGesture {
                    selectedIndex = index
                }
            }
        }
        
    }
    
}

