//
//  ArtworkViewer.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 05/06/2025.
//

import SwiftUI

struct ArtworkViewer: View {
    @State private var showFullScreen: Bool = false
    let artwork: Artwork
    let viewSize: CGFloat // dışarıdan verilecek çerçeve
    let isFullScreenAvailable: Bool

    var body: some View {
        let columns = artwork.size[0]
        let rows = artwork.size[1]
        let cellSize = viewSize / CGFloat(columns)

        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<rows, id: \.self) { row in
                GridRow {
                    ForEach(0..<columns, id: \.self) { col in
                        let index = row * columns + col
                        Rectangle()
                            .fill(Color(hex: artwork.data[index]))
                            .frame(width: cellSize, height: cellSize)
                    }
                }
            }
        }
        .frame(width: viewSize, height: cellSize * CGFloat(rows))
        .border(.black, width: 4)
        .overlay(alignment: .topTrailing) {
            if isFullScreenAvailable {
                Button {
                    showFullScreen = true
                } label: {
                    Image("ic_eye")
                        .resizable()
                        .interpolation(.none)
                        .frame(width: 20, height: 20)
                        .padding(8)
                }
            }
        }
        .fullScreenCover(isPresented: $showFullScreen) {
            FullscreenArtworkView(artwork: artwork)
        }
    }
}

#Preview {
    ArtworkViewer(artwork: MockData.artwork_mushroom, viewSize: 200, isFullScreenAvailable: true)
}

struct FullscreenArtworkView: View {
    let artwork: Artwork
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                Color.black
                    .opacity(0.8)
                    .ignoresSafeArea()
                
                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                    ForEach(0..<artwork.size[1], id: \.self) { row in
                        GridRow {
                            ForEach(0..<artwork.size[0], id: \.self) { col in
                                let index = row * artwork.size[0] + col
                                Rectangle()
                                    .fill(Color(hex: artwork.data[index]))
                                    
                            }
                        }
                    }
                }
                .frame(width: geo.size.width, height: geo.size.width)
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding()
                }
            }
        }
    }
}

/*
 static let artwork = Artwork(
     id: "1",
     authorId: "authorId",
     data: ["870058", "a4303f", "f2d0a4", "c8d6af"],
     competitionId: "competitionId",
     size: "2x2"
 )
 */
