//
//  SideOfBaseNode.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/30/24.
//

import Foundation

enum SideOfBaseNode: String, CaseIterable {
    case sideOfFather = "친가의 조직도"
    case sideOfMother = "외가의 조직도"
    case sideOfWife = "배우자의 조직도"
    
    var imageName: String {
        switch self {
        case .sideOfFather:
            "person"
        case .sideOfMother:
            "person.line.dotted.person"
        case .sideOfWife:
            "person.line.dotted.person.fill"
        }
    }
    
    func possibleChangeMode(_ node: Node?) -> Bool {
        switch self {
        case .sideOfFather:
            return node?.leftParent != nil
        case .sideOfMother:
            return node?.rightParent != nil
        case .sideOfWife:
            return node?.partner != nil
        }
    }
}
