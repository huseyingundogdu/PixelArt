//
//  ProfileContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 16/07/2025.
//

import SwiftUI
import FirebaseAuth

struct ProfileContentView: View {
    @State private var selectedIndex: Int = 0
    
    let user: AppUser
    let archived: [Artwork]
    let shared: [Artwork]
    
    let showFollowButton: Bool
    @Binding var isFollowing: Bool?
    let onFollowTapped: (() -> Void)?
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .center) {
                    ArtworkViewer(artwork: 
                                    Artwork(id: "",
                                            authorId: "",
                                            authorUsername: "",
                                            data: user.profilePictureData,
                                            competitionId: nil,
                                            size: [2, 2],
                                            topic: nil,
                                            status: .personal), viewSize: 200,
                                  isFullScreenAvailable: true
                    )
                        .scaleEffect(0.8)
                    
                    VStack(spacing: 20) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text(user.username)
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
                        .font(.custom("Micro5-Regular", size: 25))
                        
                        HStack {
                            Button {
                                
                            } label: {
                                Text("\(user.followers.count)")
                                Text("Followers")
                                    .foregroundStyle(.gray)
                            }
                            .foregroundStyle(.black)

                            Button {
                                
                            } label: {
                                Text("\(user.following.count)")
                                Text("Following")
                                    .foregroundStyle(.gray)
                            }
                            .foregroundStyle(.black)

                            Spacer()
                        }
                        .font(.custom("Micro5-Regular", size: 25))
                        
                    }
                }
                
                Rectangle()
                    .frame(height: 3)
                
                VStack(spacing: 10) {
                    Text("Gallery of \(user.username)")
                        .font(.custom("Micro5-Regular", size: 35))
                    
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
        HStack(alignment: .top) {
            ArtworkViewer(artwork: artwork, viewSize: 100, isFullScreenAvailable: true)
            VStack(alignment: .leading) {
                Text("Competition: \(artwork.topic ?? "ERROR")")
                Text("Topic: " + (artwork.topic ?? "ERROR"))
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
        .font(.custom("Micro5-Regular", size: 25))
    }
    
}

