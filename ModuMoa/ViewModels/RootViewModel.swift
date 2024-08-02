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
    var sideOfBaseNode: SideOfBaseNode = .sideOfFather
    
    func onAppear() {
        if let rawValue = UserDefaults.standard.string(forKey: "nicknameMode"), let nicknameMode = NicknameMode(rawValue: rawValue) {
            self.nicknameMode = nicknameMode
        }
        if let rawValue = UserDefaults.standard.string(forKey: "sideOfBaseNode"), let baseNodeMode = SideOfBaseNode(rawValue: rawValue) {
            self.sideOfBaseNode = baseNodeMode
        }
        guard let stringID = UserDefaults.standard.value(forKey: "baseNode") as? String else {
            self.rootViewCase = .introView
            return }
        guard let id = UUID(uuidString: stringID) else {
            self.rootViewCase = .introView
            return
        }
        let node = DatabaseModel.shared.fetchNode(id)
        self.rootViewCase = node != nil ? .familyTreeView : .introView
        if let node {
            setChildrenOfNode(node)
        }
        if let node {
            self.baseNode = node
        }
    }
    
    func setBaseNode(_ node: Node?) {
        if let node {
            UserDefaults.standard.setValue(node.id.uuidString, forKey: "baseNode")
            if rootViewCase == .introView {
                rootViewCase = .familyTreeView
            }
            setChildrenOfNode(node)
            DispatchQueue.main.async {
                self.baseNode = node
            }
        }
    }
    

    
    func changeBaseNode(_ sideOfBaseNode: SideOfBaseNode) {
        let temp = self.baseNode
        self.sideOfBaseNode = sideOfBaseNode
        self.baseNode = nil
        Task {
            do {
                try await Task.sleep(nanoseconds: 100_000_000)
                guard let stringID = UserDefaults.standard.value(forKey: "myNode") as? String else { return }
                let id = UUID(uuidString: stringID)!
                guard let myNode = DatabaseModel.shared.fetchNode(id) else { return }
                switch sideOfBaseNode {
                case .sideOfFather:
                    if let parent = myNode.leftParent {
                        UserDefaults.standard.setValue(sideOfBaseNode.rawValue, forKey: "sideOfBaseNode")
                        findRootNode(parent)
                    } else {
                        self.baseNode = temp
                    }
                case .sideOfMother:
                    if let parent = myNode.rightParent {
                        UserDefaults.standard.setValue(sideOfBaseNode.rawValue, forKey: "sideOfBaseNode")
                        findRootNode(parent)
                    } else {
                        self.baseNode = temp
                    }
                case .sideOfWife:
                    if let partner = myNode.partner {
                        UserDefaults.standard.setValue(sideOfBaseNode.rawValue, forKey: "sideOfBaseNode")
                        findRootNode(partner)
                    } else {
                        self.baseNode = temp
                    }
                }
            } catch {
                print("error")
            }
        }
        
    }
    
    func findRootNode(_ node: Node) {
        if let node = node.leftParent {
            findRootNode(node)
        } else if let node = node.rightParent {
            findRootNode(node)
        } else {
            setBaseNode(node)
        }
    }
    
    func setChildrenOfNode(_ node: Node) {
        if let partner = node.partner {
            let children = Array(Set(node.children + partner.children).sorted(by: { $0.member.birthday ?? Date() <= $1.member.birthday ?? Date()}))
            node.children = partner.children
            partner.children = children
            if !children.isEmpty {
                for child in node.children {
                    setChildrenOfNode(child)
                }
            }
        } else {
            if !node.children.isEmpty {
                for child in node.children {
                    setChildrenOfNode(child)
                }
            }
        }
    }
}
