//
//  ViewSizePreferenceKey.swift
//  ModuMoa
//
//  Created by Sooik Kim on 8/20/24.
//

import SwiftUI

struct ViewSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
