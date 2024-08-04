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
    var nicknameMode: NicknameMode
    var sideOfBaseNode: SideOfBaseNode
    
    init() {
        self.rootViewCase = .loadingView
        self.baseNode = nil
        self.isPushed = false
        self.nicknameMode = UserDefaults.standard.nicknameMode
        self.sideOfBaseNode = UserDefaults.standard.sideOfBaseNode
    }
    
    func onAppear() {
        Task {
            if let stringID = UserDefaults.standard.baseNodeID,
               let id = UUID(uuidString: stringID),
               let node = await NodeDatabase.shared.fetchNode(id) {
                setChildrenOfNode(node)
                self.baseNode = node
                self.rootViewCase = .familyTreeView
            } else {
                self.rootViewCase = .introView
            }
        }
    }
    
    func addMyNode(_ node: Node) {
        setBaseNode(node)
        rootViewCase = .familyTreeView
    }
    
    func setBaseNode(_ node: Node?) {
        if let node {
            UserDefaults.standard.baseNodeID = node.id.uuidString
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
                guard let stringID = UserDefaults.standard.myNodeID else { return }
                let id = UUID(uuidString: stringID)!
                guard let myNode = await NodeDatabase.shared.fetchNode(id) else { return }
                switch sideOfBaseNode {
                case .sideOfFather:
                    if let parent = myNode.leftParent {
                        UserDefaults.standard.sideOfBaseNode = sideOfBaseNode
                        findRootNode(parent)
                    } else {
                        self.baseNode = temp
                    }
                case .sideOfMother:
                    if let parent = myNode.rightParent {
                        UserDefaults.standard.sideOfBaseNode = sideOfBaseNode
                        findRootNode(parent)
                    } else {
                        self.baseNode = temp
                    }
                case .sideOfWife:
                    if let partner = myNode.partner {
                        UserDefaults.standard.sideOfBaseNode = sideOfBaseNode
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
            node.children = children
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
