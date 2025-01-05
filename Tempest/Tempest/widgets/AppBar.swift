//
//  CustomAppBar.swift
//  Tempest
//
//  Created by Shreyas Vilaschandra Bhike on 04/01/25.
//

import SwiftUI

struct CustomAppBar<Leading: View, Trailing: View>: View {
    let title: String
    let leadingContent: Leading
    let trailingContent: Trailing
    let backgroundColor : Color
    
    init(
        backgroundColor : Color,
        title: String,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.title = title
        self.leadingContent = leading()
        self.trailingContent = trailing()
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        ZStack {
            Color(backgroundColor)
            HStack(spacing: 16) {
                leadingContent
                Spacer()
                Text(title)
                    .font(.headline)
                    .lineLimit(1)
                Spacer()
                trailingContent
            }
            .padding(.horizontal)
        }
        .frame(height: 44)
    }
}


#Preview {
    VStack(spacing: 0) {
                CustomAppBar(
                    backgroundColor : Color.white,
                    title: "Tempest"
                ) {
                    Button(action: {
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                    }
                } trailing: {
                    HStack(spacing: 16) {
                        Button(action: {
                        }) {
                            Image(systemName: "bookmark")
                                .foregroundColor(.black)
                        }
                    }
                }
                Spacer()
    }
}
