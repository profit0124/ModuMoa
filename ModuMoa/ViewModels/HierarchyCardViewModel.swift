//
//  HierarchyCardViewModel.swift
//  ModuMoa
//
//  Created by Sooik Kim on 8/1/24.
//

import Foundation

@Observable
final class HierarchyCardViewModel {
    var node: Node
    
    var orderedChildren: [Node] {
        get {
            node.children.sorted(by: { $0.member.birthday ?? Date() < $1.member.birthday ?? Date() })
        }
    }
    
    init(node: Node) {
        self.node = node
    }
}
