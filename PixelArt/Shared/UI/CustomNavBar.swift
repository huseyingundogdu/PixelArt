//
//  CustomNavBar.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 12/05/2025.
//

import SwiftUI

struct CustomNavBar: View {
    
    var title: String = "Title"
    var subtitle: String? = nil
    var leadingButtonIcon: String?
    var leadingButtonAction: (() -> Void)?
    var trailingButtonIcon: String?
    var trailingButtonAction: (() -> Void)?
    
    
    var body: some View {
        ZStack(alignment: .center) {
            
            // Title Section
            VStack(spacing: 0) {
                Text(title)
                    .font(.Micro5.large)
                Text(subtitle ?? "")
                    .font(.Micro5.xSmall)
            }
            

            HStack {
                // Leading Button
                if let icon = leadingButtonIcon, let action = leadingButtonAction {
                    Button(action: action) {
                        PixelButton(icon: icon)
                    }
                }
                
                Spacer()
                
                // Trailing Button
                if let icon = trailingButtonIcon, let action = trailingButtonAction {
                    Button(action: action) {
                        PixelButton(icon: icon)
                    }
                }
            }
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(Color.init(hex: "3b3b3b"))
    }
}

#Preview {
    VStack {
        CustomNavBar(
            title: "Title",
            subtitle: "subtitle",
            leadingButtonIcon: "ic_comp",
            leadingButtonAction: {
                print("comp")
            },
            trailingButtonIcon: "ic_crown",
            trailingButtonAction: {
                print("crown")
            }
        )
        Spacer()
    }
}
