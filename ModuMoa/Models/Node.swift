//
//  Union.swift
//  ModuMoa
//
//  Created by KiWoong Hong on 2023/10/14.
//

import Foundation

class Node {
    var leftParent: Node?
    var rightParent: Node?
    var partner: Node?
    var children: [Node] = []
    var member: Member
    var relatedList: [Node?] {
        return [leftParent, rightParent, partner] + children
    }
    
    init(leftParent: Node? = nil, rightParent: Node? = nil, children: [Node] = [], member: Member) {
        self.leftParent = leftParent
        self.rightParent = rightParent
        self.children = children
        self.member = member
    }
    
    func add(child: Node) {
        children.append(child)
        switch member.sex {
        case .male: child.leftParent = self
        case .female: child.rightParent = self
        }
    }
    
    func add(partner: Node) {
        self.partner = partner
        partner.partner = self
    }
    
    func add(parent: Node) {
        switch parent.member.sex {
        case .male: self.leftParent = parent
        case .female: self.rightParent = parent
        }
        parent.children.append(self)
    }
    
    
}
