//
//  EnvironmnetValues+.swift
//  ModuMoa
//
//  Created by Sooik Kim on 8/20/24.
//

import SwiftUI

struct IsSmallScreenDevice: EnvironmentKey {
    static var defaultValue: Bool = false
}

struct IsNoSafeAreaDevice: EnvironmentKey {
    static var defaultValue: Bool = false
}


extension EnvironmentValues {
    var isSmallScreenDevice: Bool {
        get { self[IsSmallScreenDevice.self] }
        set { self[IsSmallScreenDevice.self] = newValue }
    }
    
    var isNoSafeAreaDevice: Bool {
        get { self[IsNoSafeAreaDevice.self] }
        set { self[IsNoSafeAreaDevice.self] = newValue }
    }
}
