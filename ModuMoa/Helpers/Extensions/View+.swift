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
}
