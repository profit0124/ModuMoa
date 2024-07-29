//
//  NicknameMode.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/29/24.
//

import Foundation

enum NicknameMode: String, CaseIterable {
    case title = "호칭"
    case nickname = "특별 호칭"
    
    var imageName: String {
        switch self {
        case .title:
            "quote.bubble"
        case .nickname:
            "star.bubble"
        }
    }
}
