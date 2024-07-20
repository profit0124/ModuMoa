//
//  KindOfAdd.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/20/24.
//

import Foundation

enum KindOfAdd: String, CaseIterable {
    case leftParent = "아버지"
    case rightParent = "어머니"
    case son = "아들"
    case daughter = "딸"
    
    func addMember(_ from: Node, _ to: Node) {
        switch self {
        case .leftParent:
            print("아버지 추가")
        case .rightParent:
            print("어머니 추가")
        case .son:
            print("add son")
        case .daughter:
            print("add daughter")
        }
    }
}
