//
//  RootViewModel.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/22/24.
//

import Foundation
import Observation

enum RootViewCase {
    case familyTreeView
    case introView
    case loadingView
}

@Observable
final class RootViewModel {
    var rootViewCase: RootViewCase = .loadingView
    var baseNode: Node?
    var isPushed: Bool = false
    var nicknameMode: NicknameMode = .nickname
    
    func onAppear() {
        if let rawValue = UserDefaults.standard.string(forKey: "nicknameMode"), let nicknameMode = NicknameMode(rawValue: rawValue) {
            self.nicknameMode = nicknameMode
        }
        guard let stringID = UserDefaults.standard.value(forKey: "baseNode") as? String else {
            self.rootViewCase = .introView
            return }
        let id = UUID(uuidString: stringID)!
        let node = DatabaseModel.shared.fetchNode(id)
        self.rootViewCase = node != nil ? .familyTreeView : .introView
        if let node {
            setBaseNode(node)
        }
    }
    
    func setBaseNode(_ node: Node?) {
        if let node {
            UserDefaults.standard.setValue(node.id.uuidString, forKey: "baseNode")
            if rootViewCase == .introView {
                rootViewCase = .familyTreeView
            }
            self.baseNode = node
        }
    }
}
