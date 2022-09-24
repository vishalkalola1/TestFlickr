//
//  Navigation.swift
//  Locale
//
//  Created by vishal on 8/21/22.
//

import SwiftUI

struct Navigation<Content>: View where Content: View {
    
    private var content: () -> Content
    private var title: String
    private var style: NavigationBarItem.TitleDisplayMode
    
    public init(title: String,
                style: NavigationBarItem.TitleDisplayMode,
                @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.style = style
        self.content = content
    }
    var body: some View {
        NavigationView {
            content()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(title)
                .edgesIgnoringSafeArea(.bottom)
        }
        .navigationViewStyle(.stack)
    }
}
