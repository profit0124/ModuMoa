////
////  FamilyTree.swift
////  ModuMoa
////
////  Created by KiWoong Hong on 2023/10/14.
////
//
//import Foundation
//
//class FamilyTree {
//    
//    private let baseNode: Node?
//    var selectedNode: Node? = nil
//    
//    init() {
//        let birthday = "19900607".toDate()
//        let baseMember = Member(name: "Hongki", bloodType: .init(abo: .O, rh: .positive), sex: .male, birthday: birthday ?? Date())
//        self.baseNode = .init(children: [], member: baseMember)
//        selectedNode = baseNode
//    }
//    
//    func addPartner(with member: Member) {
//        guard let node = selectedNode else { return }
//        let newNode = Node(member: member, level: node.partnerLevel(), distance: node.partnerDistance())
//        node.add(partner: newNode)
//    }
//    
//    func addParent(with member: Member) {
//        guard let node = selectedNode else { return }
//        let newNode = Node(member: member, level: node.parentLevel(), distance: node.parentDistance())
//        node.add(parent: newNode)
//    }
//    
//    func addChild(with member: Member) {
//        guard let node = selectedNode else { return }
//        let newNode = Node(member: member, level: node.childLevel(), distance: node.childDistance())
//        node.add(child: newNode)
//    }
//    
//    func addSibling(with member: Member) {
//        guard let node = selectedNode else { return }
//        if node.leftParent == nil,
//           node.rightParent == nil {
//            self.addParent(with: createEmptyMember())
//        }
//        
//        if let parent = node.leftParent ?? node.rightParent {
//            let newNode = Node(member: member, level: parent.childLevel(), distance: parent.childDistance())
//            parent.add(child: newNode)
//        }
//    }
//    
//    private func createEmptyMember() -> Member {
//        return Member(name: "empty",
//                      bloodType: BloodType(abo: .none, rh: .none),
//                      sex: .male,
//                      birthday: Date())
//    }
//    
//    func find(with member: Member) -> Node? {
//        let startNode = baseNode
//        var visited: [UUID:Node] = [:]
//        func findInner(current: Node?) -> Node? {
//            guard let current = current,
//                  visited[current.member.id] == nil else { return nil }
//            
//            visited[current.member.id] = current
//            
//            if member.id == current.member.id {
//                return current
//            }
//            
//            for next in current.relatedList {
//                if let foundNode = findInner(current: next) {
//                    return foundNode
//                }
//            }
//            
//            return nil
//        }
//        
//        return findInner(current: startNode)
//    }
//}
