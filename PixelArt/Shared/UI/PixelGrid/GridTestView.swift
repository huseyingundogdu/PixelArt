//
//  GridTestView.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 21/07/2025.
//

import SwiftUI

struct GridTestView: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                ScrollView {
                    PixelGridView(
                        data: GridTest.data2x2,
                        columns: 2,
                        rows: 2,
                        availableWidth: geo.size.width / 2,
                        availableHeight: geo.size.height / 5
                    )
                    
                    PixelGridView(
                        data: GridTest.data4x2,
                        columns: 4,
                        rows: 2,
                        availableWidth: geo.size.width / 2,
                        availableHeight: geo.size.height / 5
                    )
                    
                    PixelGridView(
                        data: GridTest.data4x8,
                        columns: 4,
                        rows: 8,
                        availableWidth: geo.size.width / 2,
                        availableHeight: geo.size.height / 5
                    )
                    
                    PixelGridView(
                        data: GridTest.data2x8,
                        columns: 2,
                        rows: 8,
                        availableWidth: geo.size.width / 2,
                        availableHeight: geo.size.height / 5
                    )
                    
                    PixelGridView(
                        data: GridTest.data4x16,
                        columns: 4,
                        rows: 16,
                        availableWidth: geo.size.width / 2,
                        availableHeight: geo.size.height / 5
                    )
                }
            }
        }
    }
}

#Preview {
    GridTestView()
}


struct GridTest {
    static let data2x2 = [
        "#CDD5D1", "#B4A6AB",
        "#946E83", "#615055"
    ]
    
    static let data4x2 = [
        "#CDD5D1", "#B4A6AB", "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB", "#946E83", "#615055"
    ]
    
    static let data4x8 = [
        "#CDD5D1", "#B4A6AB", "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB", "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB", "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB", "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB", "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB", "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB", "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB", "#946E83", "#615055"
    ]
    
    static let data2x4 = [
        "#CDD5D1", "#B4A6AB",
        "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB",
        "#946E83", "#615055",
    ]
    
    static let data2x8 = [
        "#CDD5D1", "#B4A6AB",
        "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB",
        "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB",
        "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB",
        "#946E83", "#615055"
    ]
    
    static let data4x16 = [
        "#CDD5D1", "#B4A6AB", "#CDD5D1", "#B4A6AB",
        "#946E83", "#615055", "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB", "#CDD5D1", "#B4A6AB",
        "#946E83", "#615055", "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB", "#CDD5D1", "#B4A6AB",
        "#946E83", "#615055", "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB", "#CDD5D1", "#B4A6AB",
        "#946E83", "#615055", "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB", "#CDD5D1", "#B4A6AB",
        "#946E83", "#615055", "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB", "#CDD5D1", "#B4A6AB",
        "#946E83", "#615055", "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB", "#CDD5D1", "#B4A6AB",
        "#946E83", "#615055", "#946E83", "#615055",
        "#CDD5D1", "#B4A6AB", "#CDD5D1", "#B4A6AB",
        "#946E83", "#615055", "#946E83", "#615055"
    ]
}
