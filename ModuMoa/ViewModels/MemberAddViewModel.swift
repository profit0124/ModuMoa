//
//  MemberAddViewModel.swift
//  ModuMoa
//
//  Created by Sooik Kim on 8/1/24.
//

import Foundation
import Observation

@Observable
final class MemberAddViewModel {
    var fromNode: Node
    var selectedAddCase: CaseOfAdd?
    
    let level: Int
    let distance: Int
    
    var name: String = ""
    var sex: Sex?
    var birthDay: Date?
    var bloodType: BloodType
    var rh: BloodType.RhType?
    var abo: BloodType.AboType?
    
    init(fromNode: Node, selectedAddCase: CaseOfAdd? = nil) {
        self.fromNode = fromNode
        self.selectedAddCase = selectedAddCase
        self.name = ""
        self.birthDay = nil
        self.bloodType = .init(abo: .none, rh: .none)
        self.rh = nil
        self.abo = nil
        
        switch selectedAddCase {
        case .leftParent:
            self.sex = .male
            self.level = fromNode.level + 1
            self.distance = fromNode.rightParent?.distance ?? fromNode.distance + 1
            
        case .rightParent:
            self.sex = .female
            self.level = fromNode.level + 1
            self.distance = fromNode.leftParent?.distance ?? fromNode.distance + 1
            
        case .partner:
            self.sex = fromNode.member.sex == .male ? .female : .male
            self.level = fromNode.level
            self.distance = fromNode.distance
    
        case .son:
            self.sex = .male
            self.level = fromNode.level - 1
            self.distance = fromNode.distance + 1
            
        case .daughter:
            self.sex = .female
            self.level = fromNode.level - 1
            self.distance = fromNode.distance + 1
            
        case nil:
            self.level = 0
            self.distance = 0
        }
    }
    
    func saveButtonTapped() async throws {
        if let sex, let selectedAddCase {
            let node = Node(member: .init(name: name, bloodType: bloodType, sex: sex, birthday: birthDay), level: level, distance: distance)
            let relationshipInfo = RelationshipInfoType(fromNode.relationshipInfo, selectedAddCase, from: fromNode, to: node)
            node.relationshipInfo = relationshipInfo!
            switch selectedAddCase {
            case .leftParent:
                fromNode.addFather(node)
            case .rightParent:
                fromNode.addMother(node)
            case .partner:
                fromNode.addPartner(node)
            case .son, .daughter:
                fromNode.addChildren(node)
            }
            let nickNames = try await relationshipInfo!.getNicknames(to: node)
            node.member.nickNames = nickNames
            try await NodeDatabase.shared.addNode(node)
            // 추가 후 해당 Hierarychy card 에서 진입 시 사용했던 selectedAddCase 를 다시 nil 로 변경
            self.selectedAddCase = nil
        }
    }
}
