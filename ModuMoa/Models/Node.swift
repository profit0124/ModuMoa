//
//  Union.swift
//  ModuMoa
//
//  Created by KiWoong Hong on 2023/10/14.
//

import Foundation
import SwiftData

@Model
final class Node: Identifiable {
    @Attribute(.unique)
    let id: UUID = UUID()
    var level: Int
    var distance: Int
    var leftParent: Node?
    var rightParent: Node?
    var partner: Node?
    var children: [Node] = []
    var member: Member
    var relationshipInfo: RelationshipInfoType
    var baseNode: Node?
    var relatedList: [Node?] {
        return [leftParent, rightParent, partner] + children
    }
    
    init(leftParent: Node? = nil, rightParent: Node? = nil, children: [Node] = [], member: Member, relationshipInfo: RelationshipInfoType = .unknown, baseNode: Node? = nil, level: Int = 0, distance: Int = 0) {
        self.leftParent = leftParent
        self.rightParent = rightParent
        self.children = children
        self.member = member
        self.level = level
        self.distance = distance
        self.relationshipInfo = relationshipInfo
        self.baseNode = baseNode
    }
    
    func addFather(_ node: Node) {
        if let mother = self.rightParent {
            mother.addPartner(node)
        } else {
            node.baseNode = self
            node.children = [self]
            self.leftParent = node
        }
    }
    
    func addMother(_ node: Node) {
        if let father = self.leftParent {
            father.addPartner(node)
        } else {
            node.baseNode = self
            node.children = [self]
            self.rightParent = node
        }
    }
    
    func addPartner(_ node: Node) {
        let children = self.children
        for child in children {
            if node.member.sex == .male {
                child.leftParent = node
            } else {
                child.rightParent = node
            }
        }
        node.children = children
        node.partner = self
        node.baseNode = self.baseNode
        self.partner = node
    }
    
    func addChildren(_ node: Node) {
        var isAdded: Bool = false
        var children: [Node] = []
        for child in self.children {
            if child.member.birthday ?? Date() >= node.member.birthday ?? Date(), !isAdded {
                children.append(node)
                isAdded = true
            }
            children.append(child)
        }
        if !isAdded {
            children.append(node)
        }
        self.children = children
        if let partner = self.partner {
            partner.children = self.children
        }
        
        if self.member.sex == .male {
            node.leftParent = self
            node.rightParent = self.partner
        } else {
            node.leftParent = self.partner
            node.rightParent = self
        }
    }
    
    func updateNicknames() async throws {
        let nickNames = try await self.relationshipInfo.getNicknames(to: self)
        self.member.nickNames = nickNames
    }
}

extension Node: Equatable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.id == rhs.id
    }
}


extension Node: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

