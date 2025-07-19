//
//  ProfileContentView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 16/07/2025.
//

import SwiftUI
import FirebaseAuth

struct ProfileContentView: View {
    @Binding var path: NavigationPath
    @State private var selectedIndex: Int = 0
    
    let user: AppUser
    let archived: [Artwork]
    let shared: [Artwork]
    
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
                                            status: .personal)
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
                        
                        Button(user.followers[0]) {
                            path.append(ProfileTo.otherUserProfile(user.followers[0]))
                        }
                    }
                }
                
                Rectangle()
                    .frame(height: 3)
                
                VStack {
                    Text("Gallery of \(user.username)")
                        .font(.custom("Micro5-Regular", size: 35))
                    
                   
                    
                    CustomSegmentedControl(
                        options: ["Competition", "Shared"],
                        selectedIndex: $selectedIndex
                    )
                    
                    if selectedIndex == 0 {
                        ForEach(archived, id: \.self) { artwork in
                            HStack {
                                ArtworkViewer(artwork: artwork)
                                    .scaleEffect(0.8)
                                
                                VStack {
                                    Text(artwork.competitionId ?? "ERROR")
                                    Text("Like - 25")
                                }
                            }
                            
                            Spacer()
                        }
                    } else {
                        ForEach(shared, id: \.self) { artwork in
                            HStack {
                                ArtworkViewer(artwork: artwork)
                                    .scaleEffect(0.8)
                                
                                Spacer()
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

#Preview {
    ProfileContentView(
        path: .constant(NavigationPath()),
        user: AppUser(
            id: "user-id",
            email: "user-email",
            username: "username",
            profilePictureData: ["#5C2751", "#6457A6", "#9DACFF", "#4BC0D9"],
            followers: [],
            following: [],
            joinedCompetitions: [],
            createdAt: .now
        ),
        archived: [],
        shared: []
    )
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

