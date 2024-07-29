//
//  RelationshipNickNameProvider.swift
//  ModuMoa
//
//  Created by KiWoong Hong on 2023/11/03.
//

import Foundation

//protocol RelationshipNickNameProvider {
//    func nickName() -> String
//}
//
//
//enum RelationshipInfoType: RelationshipNickNameProvider {
//    /// case naming -> level + distance + sex
//    case twoFourMale, twoFourFemale, twoTwoMale, twoTwoFemale
//    case oneFiveMale, oneFiveFemale, oneThreeMale, oneThreeFemale, oneOneMale, oneOneFemale
//    case zeroSixMale, zeroSixFemale, zeroFourMale, zeroFourFemale, zeroTwoMale, zeroTwoFemale, zeroZeroMale, zeroZeroFemale
//    case mOneSevenMale, mOneSevenFemale, mOneFiveMale, mOneFiveFemale
//    case mOneThreeMale, mOneThreeFemale, mOneOneMale, mOneOneFemale
//    case mTwoEightMale, mTwoEightFemale, mTwoSixMale, mTwoSixFemale
//    case mTwoFourMale, mTwoFourFemale, mTwoTwoMale, mTwoTwoFemale
//    case unknown
//    
//    init?(_ node: Node?) {
//        guard let node = node else { return nil }
//        
//        switch node.level {
//        case 2: self = RelationshipInfoType.level2Branch(distance: node.distance, sex: node.member.sex)
//        case 1: self = RelationshipInfoType.level1Branch(distance: node.distance, sex: node.member.sex)
//        case 0: self = RelationshipInfoType.level0Branch(distance: node.distance, sex: node.member.sex)
//        case -1: self = RelationshipInfoType.levelM1Branch(distance: node.distance, sex: node.member.sex)
//        case -2: self = RelationshipInfoType.levelM2Branch(distance: node.distance, sex: node.member.sex)
//        default: self = .unknown
//        }
//    }
//    
//    init(level: Int, distance: Int, sex: Sex) {
//        switch level {
//        case 2: self = RelationshipInfoType.level2Branch(distance: distance, sex: sex)
//        case 1: self = RelationshipInfoType.level1Branch(distance: distance, sex: sex)
//        case 0: self = RelationshipInfoType.level0Branch(distance: distance, sex: sex)
//        case -1: self = RelationshipInfoType.levelM1Branch(distance: distance, sex: sex)
//        case -2: self = RelationshipInfoType.levelM2Branch(distance: distance, sex: sex)
//        default: self = .unknown
//        }
//    }
//    
//    static private func level2Branch(distance: Int, sex: Sex) -> RelationshipInfoType {
//        switch (distance, sex) {
//        case (4, .male): return .twoFourMale
//        case (4, .female): return .twoFourFemale
//        case (2, .male) : return .twoTwoMale
//        case (2, .female) : return .twoTwoFemale
//        default: return .unknown
//        }
//    }
//    
//    static private func level1Branch(distance: Int, sex: Sex) -> RelationshipInfoType {
//        switch (distance, sex) {
//        case (5, .male): return .oneFiveMale
//        case (5, .female): return .oneFiveFemale
//        case (3, .male): return .oneThreeMale
//        case (3, .female): return .oneThreeFemale
//        case (1, .male): return .oneOneMale
//        case (1, .female): return .oneOneFemale
//        default: return .unknown
//        }
//    }
//    
//    static private func level0Branch(distance: Int, sex: Sex) -> RelationshipInfoType {
//        switch (distance, sex) {
//        case (0, .male): return .zeroZeroMale
//        case (0, .female): return .zeroZeroFemale
//        case (2, .male): return .zeroTwoMale
//        case (2, .female): return .zeroTwoFemale
//        case (4, .male): return .zeroFourMale
//        case (4, .female): return .zeroFourFemale
//        case (6, .male): return .zeroSixMale
//        case (6, .female): return .zeroSixFemale
//        default: return .unknown
//        }
//    }
//    
//    static private func levelM1Branch(distance: Int, sex: Sex) -> RelationshipInfoType {
//        switch (distance, sex) {
//        case (7, .male): return .mOneSevenMale
//        case (7, .female): return .mOneSevenFemale
//        case (5, .male): return .mOneFiveMale
//        case (5, .female): return .mOneFiveFemale
//        case (3, .male): return .mOneThreeMale
//        case (3, .female): return .mOneThreeFemale
//        case (1, .male): return .mOneOneMale
//        case (1, .female): return .mOneOneFemale
//        default: return .unknown
//        }
//    }
//    
//    static private func levelM2Branch(distance: Int, sex: Sex) -> RelationshipInfoType {
//        switch (distance, sex) {
//        case (8, .male): return .mTwoEightMale
//        case (8, .female): return .mTwoEightFemale
//        case (6, .male): return .mTwoSixMale
//        case (6, .female): return .mTwoSixFemale
//        case (4, .male): return .mTwoFourMale
//        case (4, .female): return .mTwoFourFemale
//        case (2, .male): return .mTwoTwoMale
//        case (2, .female): return .mTwoTwoFemale
//        default: return .unknown
//        }
//    }
//    
//    func nickName() -> String {
//        switch self {
//        case .twoFourMale: return "큰할아버지"
//        case .twoFourFemale: return "고모할머니"
//        case .twoTwoMale: return "할아버지"
//        case .twoTwoFemale: return "할머니"
//        case .oneFiveMale: return "종백숙부/당숙"
//        case .oneFiveFemale: return "내종숙"
//        case .oneThreeMale: return "백숙부"
//        case .oneThreeFemale: return "고모"
//        case .oneOneMale: return "아버지"
//        case .oneOneFemale: return "어머니"
//        case .zeroSixMale: return "고종형제"
//        case .zeroSixFemale: return "고종형제"
//        case .zeroFourMale: return "사촌"
//        case .zeroFourFemale: return "사촌"
//        case .zeroTwoMale: return "형제"
//        case .zeroTwoFemale: return "자매"
//        case .zeroZeroMale: return "남편"
//        case .zeroZeroFemale: return "아내"
//        case .mOneSevenMale: return "재종질"
//        case .mOneSevenFemale: return "내재종질"
//        case .mOneFiveMale: return "사촌조카"
//        case .mOneFiveFemale: return "사촌조카"
//        case .mOneThreeMale: return "조카"
//        case .mOneThreeFemale: return "조카"
//        case .mOneOneMale: return "아들"
//        case .mOneOneFemale: return "딸"
//        case .mTwoEightMale: return "삼종손"
//        case .mTwoEightFemale: return "내삼종손"
//        case .mTwoSixMale: return "재종손"
//        case .mTwoSixFemale: return "내재종손"
//        case .mTwoFourMale: return "이손"
//        case .mTwoFourFemale: return "종손"
//        case .mTwoTwoMale: return "손자"
//        case .mTwoTwoFemale: return "손자"
//        case .unknown: return "남"
//        }
//    }
//    
//}

enum RelationshipInfoType: Hashable, Codable {
    case me
    case son
    case daughter
    case partnerOfSon
    case partnerOfDaughter
    case grandSon
    case grandDaugter
    case father
    case mother
    case oldBrotherM
    case partnerOfOldBrotherM
    case sonOfOldBrotherM
    case daughterOfOldBrotherM
    case partnerOfSonOfOldBrotherM
    case partnerOfDaughterOfOldBrotherM
    case childOfChildOfOldBrotherM
    case oldBrotherF
    case partnerOfOldBrotherF
    case sonOfOldBrotherF
    case daughterOfOldBrotherF
    case partnerOfSonOfOldBrotherF
    case partnerOfDaughterOfOldBrotherF
    case childOfChildOfOldBrotherF
    case oldSisterM
    case partnerOfOldSisterM
    case sonOfOldSisterM
    case daughterOfOldSisterM
    case partnerOfSonOfOldSisterM
    case partnerOfDaughterOfOldSisterM
    case childOfChildOfOldSisterM
    case oldSisterF
    case partnerOfOldSisterF
    case sonOfOldSisterF
    case daughterOfOldSisterF
    case partnerOfSonOfOldSisterF
    case partnerOfDaughterOfOldSisterF
    case childOfChildOfOldSisterF
    case youngerBrotherM
    case partnerOfYoungerBrotherM
    case sonOfYoungerBrotherM
    case daughterOfYoungerBrotherM
    case partnerOfSonOfYoungerBrotherM
    case partnerOfDaughterOfYoungerBrotherM
    case childOfChildOfYoungerBrotherM
    case youngerBrotherF
    case partnerOfYoungerBrotherF
    case sonOfYoungerBrotherF
    case daughterOfYoungerBrotherF
    case partnerOfSonOfYoungerBrotherF
    case partnerOfDaughterOfYoungerBrotherF
    case childOfChildOfYoungerBrotherF
    case youngerSisterM
    case partnerOfYoungerSisterM
    case sonOfYoungerSisterM
    case daughterOfYoungerSisterM
    case partnerOfSonOfYoungerSisterM
    case partnerOfDaughterOfYoungerSisterM
    case childOfChildOfYoungerSisterM
    case youngerSisterF
    case partnerOfYoungerSisterF
    case sonOfYoungerSisterF
    case daughterOfYoungerSisterF
    case partnerOfSonOfYoungerSisterF
    case partnerOfDaughterOfYoungerSisterF
    case childOfChildOfYoungerSisterF
    case grandFatherM
    case grandMotherM
    case bigGrandFatherM
    case bigGrandMotherM
    case bigFather
    case partnerOfBigFather
    case smallFather
    case partnerOfSmallFather
    case childOfBrotherOfFather
    case partnerMOfChildOfBrotherOfFather
    case childOfChildOfBrotherOfFather
    case childOfChildOfChildOfBrotherOfFather
    case sisterOfFather
    case partnerOfSisterOfFather
    case childOfSisterOfFather
    case partnerMOfChildOfSisterOfFather
    case childOfChildOfSisterOfFather
    case childOfChildOfChildOfSisterOfFather
    case grandFatherF
    case grandMotherF
    case bigGrandFatherF
    case bigGrandMotherF
    case brotherOfMother
    case partnerOfBrotherOfMother
    case childOfBrotherOfMother
    case partnerMOfChildOfBrotherOfMother
    case childOfChildOfBrotherOfMother
    case childOfChildOfChildOfBrotherOfMother
    case sisterOfMother
    case partnerOfSisterOfMother
    case childOfSisterOfMother
    case partnerMOfChildOfSisterOfMother
    case childOfChildOfSisterOfMother
    case childOfChildOfChildOfSisterOfMother
    case wife
    case husband
    case fatherOfHusband
    case motherOfHusband
    case fatherOfWife
    case motherOfWife
    case oldBrotherOfWife
    case youngerBrotherOfWife
    case oldSisterOfWife
    case youngerSisterOfWife
    case partnerOfOldBrotherOfWife
    case partnerOfYoungerBrotherOfWife
    case partnerOfOldSisterOfWife
    case partnerOfYoungerSisterOfWife
    case oldBrotherOfHusband
    case partnerOfOldBrotherOfHusband
    case oldSisterOfHusband
    case partnerOfOldSisterOfHusband
    case youngerBrotherOfHusband
    case partnerOfYoungerBrotherOfHusband
    case youngerSisterOfHusband
    case partnerOfYoungerSisterOfHusband
    case unknown
}

extension RelationshipInfoType {
    init?(_ relation: RelationshipInfoType,_ caseOfAdd: CaseOfAdd, from fromNode: Node, to toNode: Node) {
        print(relation)
        print(caseOfAdd)
        switch relation {
        case .me:
            switch caseOfAdd {
            case .leftParent:
                self = .father
            case .rightParent:
                self = .mother
            case .partner:
                if fromNode.member.sex == .male {
                    self = .wife
                } else {
                    self = .husband
                }
            case .son:
                self = .son
            case .daughter:
                self = .daughter
            }
        case .son:
            switch caseOfAdd {
            case .leftParent:
                self = .husband
            case .rightParent:
                self = .wife
            case .partner:
                self = .partnerOfSon
            case .son:
                self = .grandSon
            case .daughter:
                self = .grandDaugter
            }
        case .daughter:
            switch caseOfAdd {
            case .leftParent:
                self = .husband
            case .rightParent:
                self = .wife
            case .partner:
                self = .partnerOfSon
            case .son:
                self = .grandSon
            case .daughter:
                self = .grandDaugter
            }
        case .partnerOfSon:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .son
            case .son:
                self = .grandSon
            case .daughter:
                self = .grandDaugter
            }
        case .partnerOfDaughter:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .daughter
            case .son:
                self = .grandSon
            case .daughter:
                self = .grandDaugter
            }
        case .grandSon:
            self = .unknown
        case .grandDaugter:
            self = .unknown
        case .father:
            switch caseOfAdd {
            case .leftParent:
                self = .grandFatherM
            case .rightParent:
                self = .grandMotherM
            case .partner:
                self = .mother
            case .son:
                switch fromNode.baseNode!.member.sex {
                case .male:
                    if fromNode.baseNode!.member.birthday ?? Date() <= toNode.member.birthday ?? Date() {
                        self = .youngerBrotherM
                    } else {
                        self = .oldBrotherM
                    }
                case .female:
                    if fromNode.baseNode!.member.birthday ?? Date() <= toNode.member.birthday ?? Date() {
                        self = .youngerBrotherF
                    } else {
                        self = .oldBrotherF
                    }
                }
            case .daughter:
                switch fromNode.baseNode!.member.sex {
                case .male:
                    if fromNode.baseNode!.member.birthday! <= toNode.member.birthday! {
                        self = .youngerSisterM
                    } else {
                        self = .oldSisterM
                    }
                case .female:
                    if fromNode.baseNode!.member.birthday! <= toNode.member.birthday! {
                        self = .youngerSisterF
                    } else {
                        self = .oldSisterF
                    }
                }
            }
        case .mother:
            switch caseOfAdd {
            case .leftParent:
                self = .grandFatherF
            case .rightParent:
                self = .grandMotherF
            case .partner:
                self = .mother
            case .son:
                switch fromNode.baseNode!.member.sex {
                case .male:
                    if fromNode.baseNode!.member.birthday! >= toNode.member.birthday! {
                        self = .youngerBrotherM
                    } else {
                        self = .oldBrotherM
                    }
                case .female:
                    if fromNode.baseNode!.member.birthday! >= toNode.member.birthday! {
                        self = .youngerBrotherF
                    } else {
                        self = .oldBrotherF
                    }
                }
            case .daughter:
                switch fromNode.baseNode!.member.sex {
                case .male:
                    if fromNode.baseNode!.member.birthday! >= toNode.member.birthday! {
                        self = .youngerSisterM
                    } else {
                        self = .oldSisterM
                    }
                case .female:
                    if fromNode.baseNode!.member.birthday! >= toNode.member.birthday! {
                        self = .youngerSisterF
                    } else {
                        self = .oldSisterF
                    }
                }
            }
        case .oldBrotherM:
            switch caseOfAdd {
            case .leftParent:
                self = .father
            case .rightParent:
                self = .mother
            case .partner:
                self = .partnerOfOldBrotherM
            case .son:
                self = .sonOfOldBrotherM
            case .daughter:
                self = .daughterOfOldBrotherM
            }
        case .partnerOfOldBrotherM:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .oldBrotherM
            case .son:
                self = .sonOfOldBrotherM
            case .daughter:
                self = .daughterOfOldBrotherM
            }
        case .sonOfOldBrotherM:
            switch caseOfAdd {
            case .leftParent:
                self = .oldBrotherM
            case .rightParent:
                self = .partnerOfOldBrotherM
            case .partner:
                self = .partnerOfSonOfOldBrotherM
            case .son:
                self = .childOfChildOfOldBrotherM
            case .daughter:
                self = .childOfChildOfOldBrotherM
            }
        case .daughterOfOldBrotherM:
            switch caseOfAdd {
            case .leftParent:
                self = .oldBrotherM
            case .rightParent:
                self = .partnerOfOldBrotherM
            case .partner:
                self = .partnerOfDaughterOfOldBrotherM
            case .son:
                self = .childOfChildOfOldBrotherM
            case .daughter:
                self = .childOfChildOfOldBrotherM
            }
        case .partnerOfSonOfOldBrotherM:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .sonOfOldBrotherM
            case .son:
                self = .childOfChildOfOldBrotherM
            case .daughter:
                self = .childOfChildOfOldBrotherM
            }
        case .partnerOfDaughterOfOldBrotherM:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .daughterOfOldBrotherM
            case .son:
                self = .childOfChildOfOldBrotherM
            case .daughter:
                self = .childOfChildOfOldBrotherM
            }
        case .childOfChildOfOldBrotherM:
            self = .unknown
            
        case .oldBrotherF:
            switch caseOfAdd {
            case .leftParent:
                self = .father
            case .rightParent:
                self = .mother
            case .partner:
                self = .partnerOfOldBrotherF
            case .son:
                self = .sonOfOldBrotherF
            case .daughter:
                self = .daughterOfOldBrotherF
            }
        case .partnerOfOldBrotherF:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .oldBrotherF
            case .son:
                self = .sonOfOldBrotherF
            case .daughter:
                self = .daughterOfOldBrotherF
            }
        case .sonOfOldBrotherF:
            switch caseOfAdd {
            case .leftParent:
                self = .oldBrotherF
            case .rightParent:
                self = .partnerOfOldBrotherF
            case .partner:
                self = .partnerOfSonOfOldBrotherF
            case .son:
                self = .childOfChildOfOldBrotherF
            case .daughter:
                self = .childOfChildOfOldBrotherF
            }
            
        case .daughterOfOldBrotherF:
            switch caseOfAdd {
            case .leftParent:
                self = .oldBrotherF
            case .rightParent:
                self = .partnerOfOldBrotherF
            case .partner:
                self = .partnerOfDaughterOfOldBrotherF
            case .son:
                self = .childOfChildOfOldBrotherF
            case .daughter:
                self = .childOfChildOfOldBrotherF
            }
            
        case .partnerOfSonOfOldBrotherF:
            switch caseOfAdd {
            case .leftParent:
                self = .oldBrotherF
            case .rightParent:
                self = .partnerOfOldBrotherF
            case .partner:
                self = .sonOfOldBrotherF
            case .son:
                self = .childOfChildOfOldBrotherF
            case .daughter:
                self = .childOfChildOfOldBrotherF
            }
        case .partnerOfDaughterOfOldBrotherF:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .daughterOfOldBrotherF
            case .son:
                self = .childOfChildOfOldBrotherF
            case .daughter:
                self = .childOfChildOfOldBrotherF
            }
        case .childOfChildOfOldBrotherF:
            self = .unknown
            
        case .oldSisterM:
            switch caseOfAdd {
            case .leftParent:
                self = .father
            case .rightParent:
                self = .mother
            case .partner:
                self = .partnerOfOldSisterM
            case .son:
                self = .sonOfOldSisterM
            case .daughter:
                self = .daughterOfOldSisterM
            }
        case .partnerOfOldSisterM:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .oldSisterF
            case .son:
                self = .sonOfOldSisterM
            case .daughter:
                self = .daughterOfOldSisterM
            }
        case .sonOfOldSisterM:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfOldSisterM
            case .rightParent:
                self = .oldSisterM
            case .partner:
                self = .partnerOfSonOfOldSisterM
            case .son:
                self = .childOfChildOfOldSisterM
            case .daughter:
                self = .childOfChildOfOldSisterM
            }
        case .daughterOfOldSisterM:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfOldSisterM
            case .rightParent:
                self = .oldSisterM
            case .partner:
                self = .partnerOfDaughterOfOldSisterM
            case .son:
                self = .childOfChildOfOldSisterM
            case .daughter:
                self = .childOfChildOfOldSisterM
            }
        case .partnerOfSonOfOldSisterM:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .sonOfOldSisterM
            case .son:
                self = .childOfChildOfOldSisterM
            case .daughter:
                self = .childOfChildOfOldSisterM
            }
        case .partnerOfDaughterOfOldSisterM:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .daughterOfOldSisterM
            case .son:
                self = .childOfChildOfOldSisterM
            case .daughter:
                self = .childOfChildOfOldSisterM
            }
        case .childOfChildOfOldSisterM:
            self = .unknown
            
        case .oldSisterF:
            switch caseOfAdd {
            case .leftParent:
                self = .father
            case .rightParent:
                self = .mother
            case .partner:
                self = .partnerOfOldSisterF
            case .son:
                self = .sonOfOldSisterF
            case .daughter:
                self = .daughterOfOldSisterF
            }
        case .partnerOfOldSisterF:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .oldSisterF
            case .son:
                self = .sonOfOldSisterF
            case .daughter:
                self = .daughterOfOldSisterF
            }
        case .sonOfOldSisterF:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfOldSisterF
            case .rightParent:
                self = .oldSisterF
            case .partner:
                self = .partnerOfSonOfOldSisterF
            case .son:
                self = .childOfChildOfOldSisterF
            case .daughter:
                self = .childOfChildOfOldSisterF
            }
        case .daughterOfOldSisterF:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfOldSisterF
            case .rightParent:
                self = .oldSisterF
            case .partner:
                self = .daughterOfOldSisterF
            case .son:
                self = .childOfChildOfOldSisterF
            case .daughter:
                self = .childOfChildOfOldSisterF
            }
        case .partnerOfSonOfOldSisterF:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfOldSisterF
            case .rightParent:
                self = .oldSisterF
            case .partner:
                self = .sonOfOldSisterF
            case .son:
                self = .childOfChildOfOldSisterF
            case .daughter:
                self = .childOfChildOfOldSisterF
            }
        case .partnerOfDaughterOfOldSisterF:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfOldSisterF
            case .rightParent:
                self = .oldSisterF
            case .partner:
                self = .daughterOfOldSisterF
            case .son:
                self = .childOfChildOfOldSisterF
            case .daughter:
                self = .childOfChildOfOldSisterF
            }
        case .childOfChildOfOldSisterF:
            self = .unknown
            
        case .youngerBrotherM:
            switch caseOfAdd {
            case .leftParent:
                self = .father
            case .rightParent:
                self = .mother
            case .partner:
                self = .partnerOfYoungerBrotherM
            case .son:
                self = .sonOfYoungerBrotherM
            case .daughter:
                self = .daughterOfYoungerBrotherM
            }
        case .partnerOfYoungerBrotherM:
            switch caseOfAdd {
            case .leftParent:
                self = .father
            case .rightParent:
                self = .mother
            case .partner:
                self = .youngerBrotherM
            case .son:
                self = .sonOfYoungerBrotherM
            case .daughter:
                self = .daughterOfYoungerBrotherM
            }
        case .sonOfYoungerBrotherM:
            switch caseOfAdd {
            case .leftParent:
                self = .youngerBrotherM
            case .rightParent:
                self = .partnerOfYoungerBrotherM
            case .partner:
                self = .partnerOfSonOfYoungerBrotherM
            case .son:
                self = .childOfChildOfYoungerBrotherM
            case .daughter:
                self = .childOfChildOfYoungerBrotherM
            }
        case .daughterOfYoungerBrotherM:
            switch caseOfAdd {
            case .leftParent:
                self = .youngerBrotherM
            case .rightParent:
                self = .partnerOfYoungerBrotherM
            case .partner:
                self = .partnerOfDaughterOfYoungerBrotherM
            case .son:
                self = .childOfChildOfYoungerBrotherM
            case .daughter:
                self = .childOfChildOfYoungerBrotherM
            }
        case .partnerOfSonOfYoungerBrotherM:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .sonOfYoungerBrotherM
            case .son:
                self = .childOfChildOfYoungerBrotherM
            case .daughter:
                self = .childOfChildOfYoungerBrotherM
            }
        case .partnerOfDaughterOfYoungerBrotherM:
            switch caseOfAdd {
            case .leftParent:
                self = .youngerBrotherM
            case .rightParent:
                self = .partnerOfYoungerBrotherM
            case .partner:
                self = .daughterOfYoungerBrotherM
            case .son:
                self = .childOfChildOfYoungerBrotherM
            case .daughter:
                self = .childOfChildOfYoungerBrotherM
            }
        case .childOfChildOfYoungerBrotherM:
            self = .unknown
            
        case .youngerBrotherF:
            switch caseOfAdd {
            case .leftParent:
                self = .father
            case .rightParent:
                self = .mother
            case .partner:
                self = .partnerOfYoungerBrotherF
            case .son:
                self = .sonOfYoungerBrotherF
            case .daughter:
                self = .daughterOfYoungerBrotherF
            }
        case .partnerOfYoungerBrotherF:
            switch caseOfAdd {
            case .leftParent:
                self = .father
            case .rightParent:
                self = .mother
            case .partner:
                self = .youngerBrotherF
            case .son:
                self = .sonOfYoungerBrotherF
            case .daughter:
                self = .daughterOfYoungerBrotherF
            }
        case .sonOfYoungerBrotherF:
            switch caseOfAdd {
            case .leftParent:
                self = .youngerBrotherF
            case .rightParent:
                self = .partnerOfYoungerBrotherF
            case .partner:
                self = .partnerOfSonOfYoungerBrotherF
            case .son:
                self = .childOfChildOfYoungerBrotherF
            case .daughter:
                self = .childOfChildOfYoungerBrotherF
            }
        case .daughterOfYoungerBrotherF:
            switch caseOfAdd {
            case .leftParent:
                self = .youngerBrotherF
            case .rightParent:
                self = .partnerOfYoungerBrotherF
            case .partner:
                self = .partnerOfDaughterOfYoungerBrotherF
            case .son:
                self = .childOfChildOfYoungerBrotherF
            case .daughter:
                self = .childOfChildOfYoungerBrotherF
            }
        case .partnerOfSonOfYoungerBrotherF:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .sonOfYoungerBrotherF
            case .son:
                self = .childOfChildOfYoungerBrotherF
            case .daughter:
                self = .childOfChildOfYoungerBrotherF
            }
        case .partnerOfDaughterOfYoungerBrotherF:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .daughterOfYoungerBrotherF
            case .son:
                self = .childOfChildOfYoungerBrotherF
            case .daughter:
                self = .childOfChildOfYoungerBrotherF
            }
        case .childOfChildOfYoungerBrotherF:
            self = .unknown
            
        case .youngerSisterM:
            switch caseOfAdd {
            case .leftParent:
                self = .father
            case .rightParent:
                self = .mother
            case .partner:
                self = .partnerOfYoungerSisterM
            case .son:
                self = .sonOfYoungerSisterM
            case .daughter:
                self = .daughterOfYoungerSisterM
            }
        case .partnerOfYoungerSisterM:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .youngerSisterM
            case .son:
                self = .sonOfYoungerSisterM
            case .daughter:
                self = .daughterOfYoungerSisterM
            }
        case .sonOfYoungerSisterM:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfYoungerSisterM
            case .rightParent:
                self = .youngerSisterM
            case .partner:
                self = .partnerOfSonOfYoungerSisterM
            case .son:
                self = .childOfChildOfYoungerSisterM
            case .daughter:
                self = .childOfChildOfYoungerSisterM
            }
        case .daughterOfYoungerSisterM:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfYoungerSisterM
            case .rightParent:
                self = .youngerSisterM
            case .partner:
                self = .partnerOfDaughterOfYoungerSisterM
            case .son:
                self = .childOfChildOfYoungerSisterM
            case .daughter:
                self = .childOfChildOfYoungerSisterM
            }
        case .partnerOfSonOfYoungerSisterM:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .sonOfYoungerSisterM
            case .son:
                self = .childOfChildOfYoungerSisterM
            case .daughter:
                self = .childOfChildOfYoungerSisterM
            }
        case .partnerOfDaughterOfYoungerSisterM:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .daughterOfYoungerSisterM
            case .son:
                self = .childOfChildOfYoungerSisterM
            case .daughter:
                self = .childOfChildOfYoungerSisterM
            }
        case .childOfChildOfYoungerSisterM:
            self = .unknown
            
        case .youngerSisterF:
            switch caseOfAdd {
            case .leftParent:
                self = .father
            case .rightParent:
                self = .mother
            case .partner:
                self = .partnerOfYoungerSisterF
            case .son:
                self = .sonOfYoungerSisterF
            case .daughter:
                self = .daughterOfYoungerSisterF
            }
        case .partnerOfYoungerSisterF:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .youngerSisterF
            case .son:
                self = .sonOfYoungerSisterF
            case .daughter:
                self = .daughterOfYoungerSisterF
            }
        case .sonOfYoungerSisterF:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfYoungerSisterF
            case .rightParent:
                self = .youngerSisterF
            case .partner:
                self = .partnerOfSonOfYoungerSisterF
            case .son:
                self = .childOfChildOfYoungerSisterF
            case .daughter:
                self = .childOfChildOfYoungerSisterF
            }
        case .daughterOfYoungerSisterF:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfYoungerSisterF
            case .rightParent:
                self = .youngerSisterF
            case .partner:
                self = .partnerOfDaughterOfYoungerSisterF
            case .son:
                self = .childOfChildOfYoungerSisterF
            case .daughter:
                self = .childOfChildOfYoungerSisterF
            }
        case .partnerOfSonOfYoungerSisterF:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .sonOfYoungerSisterF
            case .son:
                self = .childOfChildOfYoungerSisterF
            case .daughter:
                self = .childOfChildOfYoungerSisterF
            }
        case .partnerOfDaughterOfYoungerSisterF:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .daughterOfYoungerSisterF
            case .son:
                self = .childOfChildOfYoungerSisterF
            case .daughter:
                self = .childOfChildOfYoungerSisterF
            }
        case .childOfChildOfYoungerSisterF:
            self = .unknown
            
        case .grandFatherM:
            switch caseOfAdd {
            case .leftParent:
                self = .bigGrandFatherM
            case .rightParent:
                self = .bigGrandMotherM
            case .partner:
                self = .grandMotherM
            case .son:
                if fromNode.baseNode?.member.birthday ?? Date() <= toNode.member.birthday ?? Date() {
                    self = .smallFather
                } else {
                    self = .bigFather
                }
            case .daughter:
                self = .sisterOfFather
            }
        case .grandMotherM:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .grandFatherM
            case .son:
                if fromNode.baseNode?.member.birthday ?? Date() <= toNode.member.birthday ?? Date() {
                    self = .smallFather
                } else {
                    self = .bigFather
                }
            case .daughter:
                self = .sisterOfFather
            }
        case .bigGrandFatherM:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .bigGrandMotherM
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .bigGrandMotherM:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .bigGrandFatherM
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .bigFather:
            switch caseOfAdd {
            case .leftParent:
                self = .grandFatherM
            case .rightParent:
                self = .grandMotherM
            case .partner:
                self = .partnerOfBigFather
            case .son:
                self = .childOfBrotherOfFather
            case .daughter:
                self = .childOfBrotherOfFather
            }
        case .partnerOfBigFather:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .bigFather
            case .son:
                self = .childOfBrotherOfFather
            case .daughter:
                self = .childOfBrotherOfFather
            }
        case .smallFather:
            switch caseOfAdd {
            case .leftParent:
                self = .grandFatherM
            case .rightParent:
                self = .grandMotherM
            case .partner:
                self = .partnerOfSmallFather
            case .son:
                self = .childOfBrotherOfFather
            case .daughter:
                self = .childOfBrotherOfFather
            }
        case .partnerOfSmallFather:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .smallFather
            case .son:
                self = .childOfBrotherOfFather
            case .daughter:
                self = .childOfBrotherOfFather
            }
        case .childOfBrotherOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .partnerMOfChildOfBrotherOfFather
            case .son:
                self = .childOfChildOfBrotherOfFather
            case .daughter:
                self = .childOfChildOfBrotherOfFather
            }
        case .partnerMOfChildOfBrotherOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .childOfBrotherOfFather
            case .son:
                self = .childOfChildOfBrotherOfFather
            case .daughter:
                self = .childOfChildOfBrotherOfFather
            }
        case .childOfChildOfBrotherOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .unknown
            case .son:
                self = .childOfChildOfChildOfBrotherOfFather
            case .daughter:
                self = .childOfChildOfChildOfBrotherOfFather
            }
        case .childOfChildOfChildOfBrotherOfFather:
            self = .unknown
            
        case .sisterOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .grandFatherM
            case .rightParent:
                self = .grandMotherM
            case .partner:
                self = .partnerOfSisterOfFather
            case .son:
                self = .childOfSisterOfFather
            case .daughter:
                self = .childOfSisterOfFather
            }
        case .partnerOfSisterOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .grandFatherM
            case .rightParent:
                self = .grandMotherM
            case .partner:
                self = .sisterOfFather
            case .son:
                self = .childOfSisterOfFather
            case .daughter:
                self = .childOfSisterOfFather
            }
        case .childOfSisterOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfSisterOfFather
            case .rightParent:
                self = .sisterOfFather
            case .partner:
                self = .partnerMOfChildOfSisterOfFather
            case .son:
                self = .childOfChildOfSisterOfFather
            case .daughter:
                self = .childOfChildOfSisterOfFather
            }
        case .partnerMOfChildOfSisterOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .childOfSisterOfFather
            case .son:
                self = .childOfChildOfSisterOfFather
            case .daughter:
                self = .childOfChildOfSisterOfFather
            }
        case .childOfChildOfSisterOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .unknown
            case .son:
                self = .childOfChildOfChildOfSisterOfFather
            case .daughter:
                self = .childOfChildOfChildOfSisterOfFather
            }
        case .childOfChildOfChildOfSisterOfFather:
            self = .unknown
        case .grandFatherF:
            switch caseOfAdd {
            case .leftParent:
                self = .bigGrandFatherF
            case .rightParent:
                self = .bigGrandMotherF
            case .partner:
                self = .grandMotherF
            case .son:
                self = .brotherOfMother
            case .daughter:
                self = .sisterOfMother
            }
        case .grandMotherF:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .grandFatherF
            case .son:
                self = .brotherOfMother
            case .daughter:
                self = .sisterOfMother
            }
        case .bigGrandFatherF:
            switch caseOfAdd {
            case .partner:
                self = .bigGrandMotherF
            default:
                self = .unknown
            }
        case .bigGrandMotherF:
            switch caseOfAdd {
            case .partner:
                self = .bigGrandMotherF
            default:
                self = .unknown
            }
        case .brotherOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .grandFatherF
            case .rightParent:
                self = .grandMotherF
            case .partner:
                self = .partnerOfBrotherOfMother
            case .son:
                self = .childOfBrotherOfMother
            case .daughter:
                self = .childOfBrotherOfMother
            }
        case .partnerOfBrotherOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .brotherOfMother
            case .son:
                self = .childOfBrotherOfMother
            case .daughter:
                self = .childOfBrotherOfMother
            }
        case .childOfBrotherOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .brotherOfMother
            case .rightParent:
                self = .partnerOfBrotherOfMother
            case .partner:
                self = .partnerMOfChildOfBrotherOfMother
            case .son:
                self = .childOfChildOfBrotherOfMother
            case .daughter:
                self = .childOfChildOfBrotherOfMother
            }
        case .partnerMOfChildOfBrotherOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .childOfBrotherOfMother
            case .son:
                self = .childOfChildOfBrotherOfMother
            case .daughter:
                self = .childOfChildOfBrotherOfMother
            }
        case .childOfChildOfBrotherOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .unknown
            case .son:
                self = .childOfChildOfChildOfBrotherOfMother
            case .daughter:
                self = .childOfChildOfChildOfBrotherOfMother
            }
        case .childOfChildOfChildOfBrotherOfMother:
            self = .unknown
            
        case .sisterOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .grandFatherF
            case .rightParent:
                self = .grandMotherF
            case .partner:
                self = .partnerOfSisterOfMother
            case .son:
                self = .childOfSisterOfMother
            case .daughter:
                self = .childOfSisterOfMother
            }
        case .partnerOfSisterOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .sisterOfMother
            case .son:
                self = .childOfSisterOfMother
            case .daughter:
                self = .childOfSisterOfMother
            }
        case .childOfSisterOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfSisterOfMother
            case .rightParent:
                self = .sisterOfMother
            case .partner:
                self = .partnerMOfChildOfSisterOfMother
            case .son:
                self = .childOfChildOfSisterOfMother
            case .daughter:
                self = .childOfChildOfSisterOfMother
            }
        case .partnerMOfChildOfSisterOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .childOfSisterOfMother
            case .son:
                self = .childOfChildOfSisterOfMother
            case .daughter:
                self = .childOfChildOfSisterOfMother
            }
        case .childOfChildOfSisterOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .unknown
            case .son:
                self = .childOfChildOfChildOfSisterOfMother
            case .daughter:
                self = .childOfChildOfChildOfSisterOfMother
            }
        case .childOfChildOfChildOfSisterOfMother:
            self = .unknown
            
        case .wife:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfWife
            case .rightParent:
                self = .motherOfWife
            case .partner:
                self = .me
            case .son:
                self = .son
            case .daughter:
                self = .daughter
            }
        case .husband:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfHusband
            case .rightParent:
                self = .motherOfHusband
            case .partner:
                self = .me
            case .son:
                self = .son
            case .daughter:
                self = .daughter
            }
        case .fatherOfHusband:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .motherOfHusband
            case .son:
                if (fromNode.baseNode?.member.birthday ?? Date()) <= (toNode.baseNode?.member.birthday ?? Date()) {
                    self = .youngerBrotherOfHusband
                } else {
                    self = .oldBrotherOfHusband
                }
            case .daughter:
                if (fromNode.baseNode?.member.birthday ?? Date()) <= (toNode.baseNode?.member.birthday ?? Date()) {
                    self = .youngerSisterOfHusband
                } else {
                    self = .oldSisterOfHusband
                }
            }
        case .motherOfHusband:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .fatherOfHusband
            case .son:
                if (fromNode.baseNode?.member.birthday ?? Date()) <= (toNode.baseNode?.member.birthday ?? Date()) {
                    self = .youngerBrotherOfHusband
                } else {
                    self = .oldBrotherOfHusband
                }
            case .daughter:
                if (fromNode.baseNode?.member.birthday ?? Date()) <= (toNode.baseNode?.member.birthday ?? Date()) {
                    self = .youngerSisterOfHusband
                } else {
                    self = .oldSisterOfHusband
                }
            }
        case .fatherOfWife:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .motherOfWife
            case .son:
                if (fromNode.baseNode?.member.birthday ?? Date()) <= (toNode.baseNode?.member.birthday ?? Date()) {
                    self = .youngerBrotherOfWife
                } else {
                    self = .oldBrotherOfWife
                }
            case .daughter:
                if (fromNode.baseNode?.member.birthday ?? Date()) <= (toNode.baseNode?.member.birthday ?? Date()) {
                    self = .youngerSisterOfWife
                } else {
                    self = .oldSisterOfWife
                }
            }
        case .motherOfWife:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .fatherOfWife
            case .son:
                if (fromNode.baseNode?.member.birthday ?? Date()) <= (toNode.baseNode?.member.birthday ?? Date()) {
                    self = .youngerBrotherOfWife
                } else {
                    self = .oldBrotherOfWife
                }
            case .daughter:
                if (fromNode.baseNode?.member.birthday ?? Date()) <= (toNode.baseNode?.member.birthday ?? Date()) {
                    self = .youngerSisterOfWife
                } else {
                    self = .oldSisterOfWife
                }
            }
        case .oldBrotherOfWife:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfWife
            case .rightParent:
                self = .motherOfWife
            case .partner:
                self = .partnerOfOldBrotherOfWife
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .youngerBrotherOfWife:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfWife
            case .rightParent:
                self = .motherOfWife
            case .partner:
                self = .partnerOfYoungerBrotherOfWife
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .oldSisterOfWife:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfWife
            case .rightParent:
                self = .motherOfWife
            case .partner:
                self = .partnerOfOldSisterOfWife
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .youngerSisterOfWife:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfWife
            case .rightParent:
                self = .motherOfWife
            case .partner:
                self = .partnerOfYoungerSisterOfWife
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .partnerOfOldBrotherOfWife:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .oldBrotherOfWife
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .partnerOfYoungerBrotherOfWife:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .youngerBrotherOfWife
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .partnerOfOldSisterOfWife:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .oldSisterOfWife
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .partnerOfYoungerSisterOfWife:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .youngerSisterOfWife
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .oldBrotherOfHusband:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfHusband
            case .rightParent:
                self = .motherOfHusband
            case .partner:
                self = .partnerOfOldBrotherOfHusband
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .partnerOfOldBrotherOfHusband:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .oldBrotherOfHusband
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .oldSisterOfHusband:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfHusband
            case .rightParent:
                self = .motherOfHusband
            case .partner:
                self = .partnerOfOldSisterOfHusband
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .partnerOfOldSisterOfHusband:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfHusband
            case .rightParent:
                self = .motherOfHusband
            case .partner:
                self = .oldSisterOfHusband
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .youngerBrotherOfHusband:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfHusband
            case .rightParent:
                self = .motherOfHusband
            case .partner:
                self = .partnerOfYoungerBrotherOfHusband
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .partnerOfYoungerBrotherOfHusband:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfHusband
            case .rightParent:
                self = .motherOfHusband
            case .partner:
                self = .youngerBrotherOfHusband
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .youngerSisterOfHusband:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfHusband
            case .rightParent:
                self = .motherOfHusband
            case .partner:
                self = .partnerOfYoungerSisterOfHusband
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .partnerOfYoungerSisterOfHusband:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfHusband
            case .rightParent:
                self = .motherOfHusband
            case .partner:
                self = .youngerSisterOfHusband
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        default:
            self = .unknown
        }
    }
    
}


extension RelationshipInfoType {
    func getNicknames() -> Nicknames {
        switch self {
        case .me://
            Nicknames(title: "나", nickname: "나")
        case .son://
            Nicknames(title: "아들", nickname: "아들")
        case .daughter://
            Nicknames(title: "딸", nickname: "딸")
        case .partnerOfSon://
            Nicknames(title: "며느리", nickname: "며느리")
        case .partnerOfDaughter://
            Nicknames(title: "사위", nickname: "사위")
        case .grandSon://
            Nicknames(title: "손자", nickname: "손자")
        case .grandDaugter://
            Nicknames(title: "손녀", nickname: "손녀")
        case .father://
            Nicknames(title: "부", nickname: "아버지")
        case .mother://
            Nicknames(title: "모", nickname: "어머니")
        case .oldBrotherM://
            Nicknames(title: "형", nickname: "형")
        case .partnerOfOldBrotherM://
            Nicknames(title: "형수", nickname: "형수님")
        case .sonOfOldBrotherM://
            Nicknames(title: "질", nickname: "조카")
        case .daughterOfOldBrotherM://
            Nicknames(title: "질녀", nickname: "조카")
        case .partnerOfSonOfOldBrotherM://
            Nicknames(title: "질부", nickname: "조카며느리")
        case .partnerOfDaughterOfOldBrotherM://
            Nicknames(title: "질서", nickname: "조카사위")
        case .childOfChildOfOldBrotherM://
            Nicknames(title: "질손자녀", nickname: "이손자/이손녀")
        case .oldBrotherF://
            Nicknames(title: "형", nickname: "오빠")
        case .partnerOfOldBrotherF://
            Nicknames(title: "올케", nickname: "새언니")
        case .sonOfOldBrotherF://
            Nicknames(title: "질", nickname: "조카")
        case .daughterOfOldBrotherF://
            Nicknames(title: "질녀", nickname: "질녀 조카")
        case .partnerOfSonOfOldBrotherF://
            Nicknames(title: "질부", nickname: "조카며느리")
        case .partnerOfDaughterOfOldBrotherF://
            Nicknames(title: "질서", nickname: "조카사위")
        case .childOfChildOfOldBrotherF://
            Nicknames(title: "질손자녀", nickname: "이손자/이손녀")
        case .oldSisterM://
            Nicknames(title: "자", nickname: "누나")
        case .partnerOfOldSisterM://
            Nicknames(title: "매형", nickname: "매형")
        case .sonOfOldSisterM://
            Nicknames(title: "생질", nickname: "조카")
        case .daughterOfOldSisterM://
            Nicknames(title: "생질녀", nickname: "조카")
        case .partnerOfSonOfOldSisterM://
            Nicknames(title: "생질부", nickname: "조카며느리")
        case .partnerOfDaughterOfOldSisterM://
            Nicknames(title: "생질서", nickname: "조카사위")
        case .childOfChildOfOldSisterM://
            Nicknames(title: "생질손자녀", nickname: "종손자/종손녀")
        case .oldSisterF://
            Nicknames(title: "자", nickname: "언니")
        case .partnerOfOldSisterF://
            Nicknames(title: "형부", nickname: "형부")
        case .sonOfOldSisterF://
            Nicknames(title: "생질", nickname: "조카")
        case .daughterOfOldSisterF://
            Nicknames(title: "생질녀", nickname: "조카")
        case .partnerOfSonOfOldSisterF://
            Nicknames(title: "생질부", nickname: "조카며느리")
        case .partnerOfDaughterOfOldSisterF://
            Nicknames(title: "생질서", nickname: "조카사위")
        case .childOfChildOfOldSisterF://
            Nicknames(title: "생질손자녀", nickname: "종손자/종손녀")
        case .youngerBrotherM://
            Nicknames(title: "제", nickname: "남동생")
        case .partnerOfYoungerBrotherM://
            Nicknames(title: "제수", nickname: "제수씨")
        case .sonOfYoungerBrotherM://
            Nicknames(title: "질", nickname: "조카")
        case .daughterOfYoungerBrotherM://
            Nicknames(title: "질녀", nickname: "조카")
        case .partnerOfSonOfYoungerBrotherM://
            Nicknames(title: "질부", nickname: "조카며느리")
        case .partnerOfDaughterOfYoungerBrotherM://"
            Nicknames(title: "질서", nickname: "조카사위")
        case .childOfChildOfYoungerBrotherM://
            Nicknames(title: "질손자녀", nickname: "이손자/이손녀")
        case .youngerBrotherF://"
            Nicknames(title: "제", nickname: "남동생")
        case .partnerOfYoungerBrotherF://
            Nicknames(title: "올케", nickname: "올케")
        case .sonOfYoungerBrotherF://
            Nicknames(title: "질", nickname: "조카")
        case .daughterOfYoungerBrotherF://
            Nicknames(title: "질녀", nickname: "조카")
        case .partnerOfSonOfYoungerBrotherF://
            Nicknames(title: "질부", nickname: "조카며느리")
        case .partnerOfDaughterOfYoungerBrotherF://
            Nicknames(title: "질서", nickname: "조카사위")
        case .childOfChildOfYoungerBrotherF://
            Nicknames(title: "질손자녀", nickname: "이손자/이손녀")
        case .youngerSisterM://
            Nicknames(title: "매", nickname: "여동생")
        case .partnerOfYoungerSisterM://
            Nicknames(title: "매부", nickname: "매제")
        case .sonOfYoungerSisterM://
            Nicknames(title: "생질", nickname: "조카")
        case .daughterOfYoungerSisterM://
            Nicknames(title: "생질녀", nickname: "조카")
        case .partnerOfSonOfYoungerSisterM://
            Nicknames(title: "생질부", nickname: "조카며느리")
        case .partnerOfDaughterOfYoungerSisterM://
            Nicknames(title: "생질서", nickname: "조카사위")
        case .childOfChildOfYoungerSisterM://
            Nicknames(title: "생질손자녀", nickname: "종손자/종손녀")
        case .youngerSisterF://
            Nicknames(title: "매", nickname: "여동생")
        case .partnerOfYoungerSisterF://
            Nicknames(title: "제부", nickname: "제부")
        case .sonOfYoungerSisterF://
            Nicknames(title: "생질", nickname: "조카")
        case .daughterOfYoungerSisterF://
            Nicknames(title: "생질녀", nickname: "조카")
        case .partnerOfSonOfYoungerSisterF://
            Nicknames(title: "생질부", nickname: "조카며느리")
        case .partnerOfDaughterOfYoungerSisterF://
            Nicknames(title: "생질서", nickname: "조카사위")
        case .childOfChildOfYoungerSisterF://
            Nicknames(title: "생질손자녀", nickname: "종손자/종손녀")
        case .grandFatherM://
            Nicknames(title: "조부", nickname: "할아버지")
        case .grandMotherM://
            Nicknames(title: "조모", nickname: "할머니")
        case .bigGrandFatherM://
            Nicknames(title: "증조부", nickname: "증조할아버지")
        case .bigGrandMotherM://
            Nicknames(title: "증조모", nickname: "증조할머니")
        case .bigFather://
            Nicknames(title: "백부", nickname: "큰아버지")
        case .partnerOfBigFather://
            Nicknames(title: "백모", nickname: "큰어머니")
        case .smallFather://
            Nicknames(title: "숙부", nickname: "작은아버지")
        case .partnerOfSmallFather://
            Nicknames(title: "숙모", nickname: "작은어머니")
        case .childOfBrotherOfFather://
            Nicknames(title: "종형제", nickname: "사촌형제")
        case .partnerMOfChildOfBrotherOfFather://
            Nicknames(title: "종수", nickname: "")
        case .childOfChildOfBrotherOfFather://
            Nicknames(title: "종질/당질", nickname: "사촌조카")
        case .childOfChildOfChildOfBrotherOfFather://
            Nicknames(title: "재종손", nickname: "재종손")
        case .sisterOfFather://
            Nicknames(title: "고모", nickname: "고모")
        case .partnerOfSisterOfFather://
            Nicknames(title: "고모부", nickname: "고모부")
        case .childOfSisterOfFather://
            Nicknames(title: "내종형제", nickname: "사촌형제")
        case .partnerMOfChildOfSisterOfFather://
            Nicknames(title: "내종수", nickname: "")
        case .childOfChildOfSisterOfFather://
            Nicknames(title: "내종질", nickname: "사촌조카")
        case .childOfChildOfChildOfSisterOfFather://
            Nicknames(title: "내재종손", nickname: "내재종손")
        case .grandFatherF://
            Nicknames(title: "외조부", nickname: "외할아버지")
        case .grandMotherF://
            Nicknames(title: "외조모", nickname: "외할머니")
        case .bigGrandFatherF://
            Nicknames(title: "증조부", nickname: "증조외할아버지")
        case .bigGrandMotherF://
            Nicknames(title: "증조모", nickname: "증조외할머니")
        case .brotherOfMother://
            Nicknames(title: "외숙", nickname: "외삼촌")
        case .partnerOfBrotherOfMother://
            Nicknames(title: "외숙모", nickname: "외숙모")
        case .childOfBrotherOfMother://
            Nicknames(title: "외종형제", nickname: "외사촌")
        case .partnerMOfChildOfBrotherOfMother://
            Nicknames(title: "외종수", nickname: "")
        case .childOfChildOfBrotherOfMother://
            Nicknames(title: "외종질", nickname: "외사촌조카")
        case .childOfChildOfChildOfBrotherOfMother://
            Nicknames(title: "외재종손", nickname: "외재종손")
        case .sisterOfMother://
            Nicknames(title: "이모", nickname: "이모")
        case .partnerOfSisterOfMother://
            Nicknames(title: "이모부", nickname: "이모부")
        case .childOfSisterOfMother://
            Nicknames(title: "이종형제", nickname: "외사촌")
        case .partnerMOfChildOfSisterOfMother://
            Nicknames(title: "이종수", nickname: "")
        case .childOfChildOfSisterOfMother://
            Nicknames(title: "이종질", nickname: "외사촌조카")
        case .childOfChildOfChildOfSisterOfMother://
            Nicknames(title: "이재종손", nickname: "이재종손")
        case .wife://
            Nicknames(title: "아내", nickname: "아내")
        case .husband://
            Nicknames(title: "남편", nickname: "남편")
        case .fatherOfHusband://
            Nicknames(title: "시부모", nickname: "시아버지")
        case .motherOfHusband://
            Nicknames(title: "시부모", nickname: "시어머니")
        case .fatherOfWife://
            Nicknames(title: "장인", nickname: "장인어른")
        case .motherOfWife://
            Nicknames(title: "장모", nickname: "장모님")
        case .oldBrotherOfWife://
            Nicknames(title: "손윗처남", nickname: "형님")
        case .youngerBrotherOfWife://
            Nicknames(title: "처남", nickname: "처남")
        case .oldSisterOfWife://
            Nicknames(title: "처형", nickname: "처형")
        case .youngerSisterOfWife://
            Nicknames(title: "처제", nickname: "처제")
        case .partnerOfOldBrotherOfWife://
            Nicknames(title: "손윗처남댁", nickname: "아주머니")
        case .partnerOfYoungerBrotherOfWife://
            Nicknames(title: "처남댁", nickname: "처남댁")
        case .partnerOfOldSisterOfWife://
            Nicknames(title: "손윗동서", nickname: "형님")
        case .partnerOfYoungerSisterOfWife://
            Nicknames(title: "동서", nickname: "동서")
        case .oldBrotherOfHusband://
            Nicknames(title: "시아주버니", nickname: "아주버님")
        case .partnerOfOldBrotherOfHusband://
            Nicknames(title: "손윗동서", nickname: "형님")
        case .oldSisterOfHusband://
            Nicknames(title: "시누이", nickname: "형님")
        case .partnerOfOldSisterOfHusband://
            Nicknames(title: "시자부", nickname: "아주버님")
        case .youngerBrotherOfHusband://
            Nicknames(title: "시동생", nickname: "도련님")
        case .partnerOfYoungerBrotherOfHusband://
            Nicknames(title: "동서", nickname: "동서")
        case .youngerSisterOfHusband://
            Nicknames(title: "시누이", nickname: "아가씨")
        case .partnerOfYoungerSisterOfHusband://
            Nicknames(title: "시매부", nickname: "시매부")
        default:
            Nicknames(title: "모름", nickname: "모름")
        }
    }
}
