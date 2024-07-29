//
//  EnvironmentValues+.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/30/24.
//

import SwiftUI

extension EnvironmentValues {
    var nicknameMode: NicknameMode {
        get { self[NicknameModeEnvironment.self] }
        set { self[NicknameModeEnvironment.self] = newValue }
    }
}
