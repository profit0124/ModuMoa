//
//  View+.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/17/24.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat = .zero, corners: UIRectCorner = .allCorners) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func customHalfSheet(_ isPresented: Binding<Bool>, @ViewBuilder sheetContent: @escaping () -> some View) -> some View {
        modifier(CustomHalfSheet(isPresented: isPresented, sheetContent: sheetContent))
    }
    
    func customDynamicHeightSheet(_ isPresented: Binding<Bool>, @ViewBuilder sheetContent: @escaping () -> some View) -> some View {
        modifier(CustomDynamicHeightSheet(isPresented: isPresented, sheetContent: sheetContent))
    }
    
    @ViewBuilder
    public func onReadSize(_ perform: @escaping (CGSize) -> Void) -> some View {
        self.background(alignment: .center) {
            GeometryReader { reader in
                Color.clear
                    .preference(key: ViewSizePreferenceKey.self, value: reader.size)
            }
        }
        .onPreferenceChange(ViewSizePreferenceKey.self, perform: perform)
    }
}
