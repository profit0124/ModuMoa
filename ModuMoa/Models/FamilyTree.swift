//
//  FamilyTree.swift
//  ModuMoa
//
//  Created by KiWoong Hong on 2023/10/14.
//

import Foundation

class FamilyTree {
    
    private let baseNode: Node?
    var selectedNode: Node? = nil
    
    init() {
        let birthday = "19900607".toDate()
        let baseMember = Member(name: "Hongki", bloodType: .init(abo: .O, rh: .positive), sex: .male, birthday: birthday ?? Date())
        self.baseNode = .init(children: [], member: baseMember)
        selectedNode = baseNode
    }
    
    func addPartner(with member: Member) {
        let newNode = Node(member: member)
        selectedNode?.add(partner: newNode)
    }
    
    func addParent(with member: Member) {
        let newNode = Node(member: member)
        selectedNode?.add(parent: newNode)
    }
    
    func addChild(with member: Member) {
        let newNode = Node(member: member)
        selectedNode?.add(child: newNode)
    }
    
    func addBrotherOrSister(with member: Member) {
        if selectedNode?.leftParent == nil,
           selectedNode?.rightParent == nil {
            self.addParent(with: createEmptyMember())
        }
        
        if let parent = selectedNode?.leftParent ?? selectedNode?.rightParent {
            parent.add(child: Node(member: member))
        }
    }
    
    private func createEmptyMember() -> Member {
        return Member(name: "empty",
                      bloodType: BloodType(abo: .none, rh: .none),
                      sex: .male,
                      birthday: Date())
    }
    
    func find(with member: Member) -> Node? {
        let startNode = baseNode
        var visited: [UUID:Node] = [:]
        func findInner(current: Node?) -> Node? {
            guard let current = current,
                  visited[current.member.id] == nil else { return nil }
            
            visited[current.member.id] = current
            
            if member.id == current.member.id {
                return current
            }
            
            for next in current.relatedList {
                if let foundNode = findInner(current: next) {
                    return foundNode
                }
            }
            
            return nil
        }
        
        return findInner(current: startNode)
    }
}
