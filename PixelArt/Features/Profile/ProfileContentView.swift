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
    
    let user: User?
    let archived: [Artwork]
    let shared: [Artwork]
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                VStack(alignment: .center) {
                    ArtworkViewer(artwork: MockData.personArtwork)
                        .scaleEffect(0.8)
                    
                    VStack(spacing: 20) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text("User name")
                                
                                
                                Text(user?.email ?? "ERROR!")
                                    .foregroundStyle(.gray)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("24")
                            Text("Followers")
                                .foregroundStyle(.gray)
                            
                            Text("12")
                            Text("Following")
                                .foregroundStyle(.gray)
                            
                            Spacer()
                        }
                    }
                }
                
                Rectangle()
                    .frame(height: 3)
                
                VStack {
                    Text("Gallery of \(user?.email ?? "ERROR")")
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

