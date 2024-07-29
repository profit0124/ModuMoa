//
//  Union.swift
//  ModuMoa
//
//  Created by KiWoong Hong on 2023/10/14.
//

import Foundation
import SwiftData

@Model
final class Node: Equatable, Identifiable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.id == rhs.id
    }
    
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
    
    func setNickname() {
        guard let partner = self.partner else { return }
        guard let stringID = UserDefaults.standard.value(forKey: "myNode") as? String else { return }
        let id = UUID(uuidString: stringID)!
        guard let myNode = DatabaseModel.shared.fetchNode(id) else { return }
        
        if myNode.member.sex == .male {
            if partner.member.sex == .male {
                // 사촌형의 아내
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    self.member.nickNames.nickname = "형수님"
                // 사촌남동생의 아내
                } else {
                    self.member.nickNames.nickname = "제수씨"
                }
            } else {
                // 사촌누나의 남편
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    self.member.nickNames.nickname = "매형"
                // 사촌여동생의 남편
                } else {
                    self.member.nickNames.nickname = "매제"
                }
            }
        } else {
            if partner.member.sex == .male {
                // 사촌오빠의 아내
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    self.member.nickNames.nickname = "새언니"
                // 사촌남동생의 아내
                } else {
                    self.member.nickNames.nickname = "올케"
                }
            } else {
                // 사촌언니의 남편
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    self.member.nickNames.nickname = "형부"
                // 사촌여동생의 남편
                } else {
                    self.member.nickNames.nickname = "제부"
                }
            }
        }
        
        
    }
}


extension Node: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(member)
    }
}

