//
//  DynamicHeightBottomSheetContentView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 8/20/24.
//

import SwiftUI

struct DynamicHeightBottomSheetContentView<Content: View>: View where Content: View {
    let content: () -> Content
    @Binding var size: CGSize
    
    init(_ size: Binding<CGSize>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self._size = size
    }
    
    var body: some View {
        self.content()
            .onReadSize {
                size = $0
            }
    }
}
