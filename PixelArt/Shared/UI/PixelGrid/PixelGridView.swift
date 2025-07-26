//
//  PixelGridView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 21/07/2025.
//

import SwiftUI

struct PixelGridView: View {
    let data: [String]
    let columns: Int
    let rows: Int
    let availableWidth: CGFloat
    let availableHeight: CGFloat
    var showStyle: Bool = true
    
    @State private var isShowingFullScreen = false
    
    var body: some View {
    
        let cellSize = showStyle
        ? min((availableWidth - 20) / CGFloat(columns), (availableHeight - 20) / CGFloat(rows))
        : min((availableWidth) / CGFloat(columns), (availableHeight) / CGFloat(rows))
        
        let contentWidth = cellSize * CGFloat(columns)
        let contentHeight = cellSize * CGFloat(rows)
        
        return ZStack(alignment: .leading) {
            Color.clear
                
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(0..<rows, id: \.self) { row in
                    GridRow {
                        ForEach(0..<columns, id: \.self) { col in
                            let index = row * columns + col
                            Rectangle()
                                .fill(Color(hex: data[index]))
                                .frame(width: cellSize, height: cellSize)
                        }
                    }
                }
            }
            .frame(width: contentWidth, height: contentHeight)
            .border(Color.black, width: showStyle ? 2 : 0)
            .pixelBackground(paddingValue: showStyle ? 10 : 0)
            
            
        }
        .frame(width: availableWidth, height: availableHeight, alignment: .leading)
        
        .onTapGesture {
            isShowingFullScreen = true
        }
        .fullScreenCover(isPresented: $isShowingFullScreen) {
            FullScreenGridView(
                data: data,
                columns: columns,
                rows: rows
            )
        }
    }
}

struct FullScreenGridView: View {
    let data: [String]
    let columns: Int
    let rows: Int
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                Color.black
                    .opacity(0.8)
                    .ignoresSafeArea()
                
                PixelGridView(
                    data: data,
                    columns: columns,
                    rows: rows,
                    availableWidth: geo.size.width,
                    availableHeight: geo.size.width,
                    showStyle: false
                )
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

#Preview {
    VStack {
        PixelGridView(
            data: PreviewHelpers.data2x2,
            columns: 2,
            rows: 2,
            availableWidth: 125,
            availableHeight: 125
        )
        PixelGridView(
            data: PreviewHelpers.data4x2,
            columns: 4,
            rows: 2,
            availableWidth: 125,
            availableHeight: 125
        )
        
        PixelGridView(
            data: MockData.personArtwork.data,
            columns: 33,
            rows: 33,
            availableWidth: 200,
            availableHeight: 200
        )
    }
}

private struct PreviewHelpers {
    static let data2x2: [String] = [
        "#CDD5D1",
        "#B4A6AB",
        "#946E83",
        "#615055"
    ]
    
    static let data4x2: [String] = [
        "#CDD5D1",
        "#B4A6AB",
        "#946E83",
        "#615055",
        "#615055",
        "#946E83",
        "#B4A6AB",
        "#CDD5D1"
    ]
}



