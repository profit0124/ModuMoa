//
//  AddMyInformationViewModel.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/22/24.
//

import SwiftUI
import Observation

@Observable
final class AddMyInformationViewModel {
    var name: String = ""
    var sex: Sex?
    var birthDay: Date = Date()
    var rhType: BloodType.RhType?
    var aboType: BloodType.AboType?
    var caseOfAddMyInfromationView: CaseOfAddMyInformationView = .intro
    
    func nextButtonTapped() {
        if let next = caseOfAddMyInfromationView.getNext() {
            caseOfAddMyInfromationView = next
        }
    }
    
    func previousButtonTapped() {
        if let previous = caseOfAddMyInfromationView.getPrevious() {
            caseOfAddMyInfromationView = previous
        }
    }
    
    func getNode() -> Node? {
        if let sex, let rhType, let aboType {
            let relationshipInfo: RelationshipInfoType = .me
            let nickNames = Nicknames(title: "나", nickname: "나")
            return Node(member: Member(name: name, bloodType: BloodType(abo: aboType, rh: rhType), sex: sex, birthday: birthDay, nickNames: nickNames), relationshipInfo: relationshipInfo)
        } else {
            return nil
        }
    }
    
    func saveMyInformation() async -> Node? {
        if let node = getNode() {
            do {
                UserDefaults.standard.myNodeID = node.id.uuidString
                try await NodeDatabase.shared.addNode(node)
                return node
            } catch {
                print("error: \(error)")
                return node
            }
        }
        return nil
    }
}
