//
//  KindOfAdd.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/20/24.
//

import Foundation

enum CaseOfAdd: String, CaseIterable {
    case leftParent = "아버지"
    case rightParent = "어머니"
    case partner = "배우자"
    case son = "아들"
    case daughter = "딸"
    
    func canAddMember(_ node: Node) -> Bool {
        switch self {
        case .leftParent:
            return node.leftParent == nil
        case .rightParent:
            return node.rightParent == nil
        case .partner:
            return node.partner == nil
        default:
            return true
        }
    }
}
