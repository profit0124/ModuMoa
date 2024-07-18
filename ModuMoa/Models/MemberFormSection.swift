//
//  MemberFormCase.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/18/24.
//

import SwiftUI

enum MemberFormSection: String {
    case name = "이름"
    case sex = "성별"
    case birthDay = "생일"
    case rh = "RH식"
    case abo = "혈액형"
    
    func getSectionPlaceholder() -> String {
        switch self {
        case .name:
            "이름"
        case .sex:
            "성별을 선택해주세요."
        case .birthDay:
            "생일을 입력해주세요."
        case .rh:
            "RH식"
        case .abo:
            "혈액형"
        }
    }
}
