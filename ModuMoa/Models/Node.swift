//
//  Union.swift
//  ModuMoa
//
//  Created by KiWoong Hong on 2023/10/14.
//

import Foundation

class Node {
    
    private let level: Int
    private let distance: Int
    var leftParent: Node?
    var rightParent: Node?
    var partner: Node?
    var children: [Node] = []
    var member: Member
    var relatedList: [Node?] {
        return [leftParent, rightParent, partner] + children
    }
    
    init(leftParent: Node? = nil, rightParent: Node? = nil, children: [Node] = [], member: Member, level: Int = 0, distance: Int = 0) {
        self.leftParent = leftParent
        self.rightParent = rightParent
        self.children = children
        self.member = member
        self.level = level
        self.distance = distance
    }
    
    func add(child: Node) {
        children.append(child)
        switch member.sex {
        case .male: child.leftParent = self
        case .female: child.rightParent = self
        default:
            break
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
        default:
            break
        }
        parent.children.append(self)
    }
    
    func partnerLevel() -> Int {
        return level
    }
    
    func siblingLevel() -> Int {
        return level
    }
    
    func parentLevel() -> Int {
        return level + 1
    }
    
    func childLevel() -> Int {
        return level - 1
    }
    
    func partnerDistance() -> Int {
        return distance
    }
    
    func siblingDistance() -> Int {
        return distance + 2
    }
    
    func parentDistance() -> Int {
        return distance + 1
    }
    
    func childDistance() -> Int {
        return distance + 1
    }
}
