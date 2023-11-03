//
//  RelationshipNickNameProvider.swift
//  ModuMoa
//
//  Created by KiWoong Hong on 2023/11/03.
//

import Foundation

protocol RelationshipNickNameProvider {
    func nickName() -> String
}


enum RelationshipInfoType: RelationshipNickNameProvider {
    /// case naming -> level + distance + sex
    case twoFourMale, twoFourFemale, twoTwoMale, twoTwoFemale
    case oneFiveMale, oneFiveFemale, oneThreeMale, oneThreeFemale, oneOneMale, oneOneFemale
    case zeroSixMale, zeroSixFemale, zeroFourMale, zeroFourFemale, zeroTwoMale, zeroTwoFemale
    case mOneSevenMale, mOneSevenFemale, mOneFiveMale, mOneFiveFemale
    case mOneThreeMale, mOneThreeFemale, mOneOneMale, mOneOneFemale
    case mTwoEightMale, mTwoEightFemale, mTwoSixMale, mTwoSixFemale
    case mTwoFourMale, mTwoFourFemale, mTwoTwoMale, mTwoTwoFemale
    case unknown
    
    init?(_ node: Node?) {
        guard let node = node else { return nil }
        
        switch node.level {
        case 2: self = RelationshipInfoType.level2Branch(distance: node.distance, sex: node.member.sex)
        case 1: self = RelationshipInfoType.level1Branch(distance: node.distance, sex: node.member.sex)
        case 0: self = RelationshipInfoType.level0Branch(distance: node.distance, sex: node.member.sex)
        case -1: self = RelationshipInfoType.levelM1Branch(distance: node.distance, sex: node.member.sex)
        case -2: self = RelationshipInfoType.levelM2Branch(distance: node.distance, sex: node.member.sex)
        default: self = .unknown
        }
    }
    
    static private func level2Branch(distance: Int, sex: Sex) -> RelationshipInfoType {
        switch (distance, sex) {
        case (4, .male): return .twoFourMale
        case (4, .female): return .twoFourFemale
        case (2, .male) : return .twoTwoMale
        case (2, .female) : return .twoTwoFemale
        default: return .unknown
        }
    }
    
    static private func level1Branch(distance: Int, sex: Sex) -> RelationshipInfoType {
        switch (distance, sex) {
        case (5, .male): return .oneFiveMale
        case (5, .female): return .oneFiveFemale
        case (3, .male): return .oneThreeMale
        case (3, .female): return .oneThreeMale
        case (1, .male): return .oneOneMale
        case (1, .female): return .oneOneMale
        default: return .unknown
        }
    }
    
    static private func level0Branch(distance: Int, sex: Sex) -> RelationshipInfoType {
        switch (distance, sex) {
        default: return .unknown
        }
    }
    
    static private func levelM1Branch(distance: Int, sex: Sex) -> RelationshipInfoType {
        switch (distance, sex) {
        case (7, .male): return .mTwoEightMale
        case (7, .female): return .mTwoEightFemale
        case (5, .male): return .mTwoSixMale
        case (5, .female): return .mTwoSixFemale
        case (3, .male): return .mTwoFourMale
        case (3, .female): return .mTwoFourFemale
        case (1, .male): return .mTwoTwoMale
        case (1, .female): return .mTwoTwoFemale
        default: return .unknown
        }
    }
    
    static private func levelM2Branch(distance: Int, sex: Sex) -> RelationshipInfoType {
        switch (distance, sex) {
        case (8, .male): return .mOneSevenMale
        case (8, .female): return .mOneSevenFemale
        case (6, .male): return .mOneFiveMale
        case (6, .female): return .mOneFiveFemale
        case (4, .male): return .mOneThreeMale
        case (4, .female): return .mOneThreeMale
        case (2, .male): return .mOneOneMale
        case (2, .female): return .mOneOneMale
        default: return .unknown
        }
    }
    
    func nickName() -> String {
        switch self {
        case .twoFourMale: return "큰할아버지"
        case .twoFourFemale: return "고모할머니"
        case .twoTwoMale: return "할아버지"
        case .twoTwoFemale: return "할머니"
        case .oneFiveMale: return "종백숙부/당숙"
        case .oneFiveFemale: return "내종숙"
        case .oneThreeMale: return "백숙부"
        case .oneThreeFemale: return "고모"
        case .oneOneMale: return "아버지"
        case .oneOneFemale: return "어머니"
        case .zeroSixMale: return "고종형제"
        case .zeroSixFemale: return "고종형제"
        case .zeroFourMale: return "사촌"
        case .zeroFourFemale: return "사촌"
        case .zeroTwoMale: return "형제"
        case .zeroTwoFemale: return "자매"
        case .mOneSevenMale: return "재종질"
        case .mOneSevenFemale: return "내재종질"
        case .mOneFiveMale: return "사촌조카"
        case .mOneFiveFemale: return "사촌조카"
        case .mOneThreeMale: return "조카"
        case .mOneThreeFemale: return "조카"
        case .mOneOneMale: return "아들"
        case .mOneOneFemale: return "딸"
        case .mTwoEightMale: return "삼종손"
        case .mTwoEightFemale: return "내삼종손"
        case .mTwoSixMale: return "재종손"
        case .mTwoSixFemale: return "내재종손"
        case .mTwoFourMale: return "이손"
        case .mTwoFourFemale: return "종손"
        case .mTwoTwoMale: return "손자"
        case .mTwoTwoFemale: return "손자"
        case .unknown: return "남"
        }
    }
    
}
