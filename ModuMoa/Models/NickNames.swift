//
//  RelationshipProtocol.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/24/24.
//

import Foundation

struct Nicknames: Equatable, Hashable, Codable {
    var title: String
    var nickname: String
    
    var leftParent: Bool
    var rightParent: Bool
    var partner: Bool
    var son: Bool
    var daughter: Bool
    
    init(title: String, nickname: String, leftParent: Bool = true, rightParent: Bool = true, partner: Bool = true, son: Bool = true, daughter: Bool = true) {
        self.title = title
        self.nickname = nickname
        self.leftParent = leftParent
        self.rightParent = rightParent
        self.partner = partner
        self.son = son
        self.daughter = daughter
    }
    
    func checkPossible(_ caseOfAdd: CaseOfAdd) -> Bool {
        switch caseOfAdd {
        case .leftParent:
            leftParent
        case .rightParent:
            rightParent
        case .partner:
            partner
        case .son:
            son
        case .daughter:
            daughter
        }
    }
}
