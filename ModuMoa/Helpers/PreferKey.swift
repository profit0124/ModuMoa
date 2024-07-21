//
//  PreferKey.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/21/24.
//

import SwiftUI

struct PreferKey<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key: Value] { [:] }
    static func reduce(value: inout [Key: Value], nextValue: () -> [Key: Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}
