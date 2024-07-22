//
//  CaseOfAddMyInformationView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/22/24.
//

import Foundation

enum CaseOfAddMyInformationView {
    case intro
    case name
    case sex
    case birthday
    case bloodType
    
    func getNext() -> CaseOfAddMyInformationView? {
        switch self {
        case .intro:
            return .name
        case .name:
            return .sex
        case .sex:
            return .birthday
        case .birthday:
            return .bloodType
        case .bloodType:
            return nil
        }
    }
    
    func getPrevious() -> CaseOfAddMyInformationView? {
        switch self {
        case .intro:
            return .intro
        case .name:
            return .intro
        case .sex:
            return .name
        case .birthday:
            return .sex
        case .bloodType:
            return .birthday
        }
    }
}
