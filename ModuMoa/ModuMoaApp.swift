//
//  ModuMoaApp.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/9/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct ModuMoaApp: App {
    var body: some Scene {
        WindowGroup {
            MemberAddView(from: .init(member: .init(name: "adsf", bloodType: .init(abo: .A, rh: .negative), sex: .female)), addCase: .leftParent)
//            ContentView()
        }
    }
}
