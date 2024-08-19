//
//  MemberUpdateViewModel.swift
//  ModuMoa
//
//  Created by Sooik Kim on 8/1/24.
//

import Foundation
import Observation

@Observable
final class MemberUpdateViewModel {
    var node: Node
    var name: String
    var sex: Sex?
    var birthDay: Date?
    var bloodType: BloodType
    var rh: BloodType.RhType?
    var abo: BloodType.AboType?
    
    var isEnabled: Bool {
        if name.isEmpty || sex == nil {
            return false
        }
        if node.member.name != name {
            return true
        }
        if node.member.sex != sex {
            return true
        }
        if node.member.birthday != birthDay {
            return true
        }
        if node.member.bloodType != bloodType {
            return true
        }
        
        return false
    }
    
    init(node: Node) {
        self.node = node
        self.name = node.member.name
        self.sex = node.member.sex
        self.birthDay = node.member.birthday
        self.rh = node.member.bloodType.rh
        self.abo = node.member.bloodType.abo
        self.bloodType = node.member.bloodType
    }
    
    func saveButtonTapped() async throws {
        guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
        guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
        guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
        // 성별, 혹은 생일의 변경으로 호칭의 변화가 필요한지를 검증하는 변수
        var needToUpdateNicknames: Bool = false
        var level: Int = 0
        var distance: [Int] = [0]
        node.member.name = name
        
        // 나의 성별의 바뀌었을 경우, 형제, 자매, 사촌의 그리고 그의 파트너의 호칭을 변경해주기 위함
        if let sex, node.member.sex != sex {
            node.member.sex = sex
            if node == myNode {
                needToUpdateNicknames = true
                level = 0
                distance = [0, 2, 4]
            }
        }
        if let rh {
            bloodType.rh = rh
        } else {
            bloodType.rh = .none
        }
        if let abo {
            bloodType.abo = abo
        } else {
            bloodType.abo = .none   
        }
        node.member.bloodType = bloodType
        // 나의 생일 혹은 아버지의 생일 바뀌었을 경우 그로 인해 호칭의 변화가 필요한 모든 사람의 호칭을 변경하기 위함
        if node.member.birthday != birthDay {
            node.member.birthday = birthDay
            if node == myNode {
                needToUpdateNicknames = true
                level = 0
                distance = [2, 4]
            } else if node == myNode.partner {
                needToUpdateNicknames = true
                level = 0
                distance = [2, 4]
            } else if node == myNode.leftParent {
                needToUpdateNicknames = true
                level = 1
                distance = [3]
            }
        }
        
        // 내가 아닌 다른 사람의 호칭의 변경이 필요한 경우
        if needToUpdateNicknames {
            let updateNodes = try await NodeDatabase.shared.fetchNode(level: level, distance: distance)
            for updateNode in updateNodes {
                try await updateNode.updateNicknames()
            }
        }
        try await node.updateNicknames()
        try await NodeDatabase.shared.save()
    }
}
