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
    
    func saveButtonTapped() {
        node.member.name = name
        if let sex {
            node.member.sex = sex
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
        node.member.birthday = birthDay
    }
}
