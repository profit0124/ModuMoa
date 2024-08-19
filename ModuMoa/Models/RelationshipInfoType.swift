//
//  RelationshipNickNameProvider.swift
//  ModuMoa
//
//  Created by KiWoong Hong on 2023/11/03.
//

import Foundation

enum RelationshipInfoType: Hashable, Codable {
    // 직계
    case me
    case son, partnerOfSon, daughter, partnerOfDaughter, grandSon, grandDaughter
    case father, mother
    // 형제, 자매
    case sonOfParent, partnerOfSonOfParent, sonOfSonOfParent, partnerOfSonOfSonOfParent, daughterOfSonOfParent, partnerOfDaughterOfSonOfParent, childOfSonOfSonOfParent, childOfDaughterOfSonOfParent
    case daughterOfParent, partnerOfDaughterOfParent, sonOfDaughterOfParent, partnerOfSonOfDaughterOfParent, daughterOfDaughterOfParent, partnerOfDaughterOfDaughterOfParent, childOfSonOfDaughterOfParent, childOfDaughterOfDaughterOfParent
    // 친가
    case fatherOfFather, motherOfFather
    case sonOfFatherOfFather, partnerOfSonOfFatherOfFather, sonOfSonOfFatherOfFather, partnerOfSonOfSonOfFatherOfFather, childOfSonOfSonOfFatherOfFather, daughterOfSonOfFatherOfFather, partnerOfDaughterOfSonOfFatherOfFather, childOfDaughterOfSonOfFatherOfFather
    case daughterOfFatherOfFather, partnerOfDaughterOfFatherOfFather, sonOfDaughterOfFatherOfFather, partnerOfSonOfDaughterOfFatherOfFather, childOfSonOfDaughterOfFatherOfFather, daughterOfDaughterOfFatherOfFather, partnerOfDaughterOfDaughterOfFatherOfFather, childOfDaughterOfDaughterOfFatherOfFather
    // 외가
    case fatherOfMother, motherOfMother
    case sonOfFatherOfMother, partnerOfSonOfFatherOfMother, sonOfSonOfFatherOfMother, partnerOfSonOfSonOfFatherOfMother, childOfSonOfSonOfFatherOfMother, daughterOfSonOfFatherOfMother, partnerOfDaughterOfSonOfFatherOfMother, childOfDaughterOfSonOfFatherOfMother
    case daughterOfFatherOfMother, partnerOfDaughterOfFatherOfMother, sonOfDaughterOfFatherOfMother, partnerOfSonOfDaughterOfFatherOfMother, childOfSonOfDaughterOfFatherOfMother, daughterOfDaughterOfFatherOfMother, partnerOfDaughterOfDaughterOfFatherOfMother, childOfDaughterOfDaughterOfFatherOfMother
    // 배우자
    case wife
    case husband
    case fatherOfHusband
    case motherOfHusband
    case fatherOfWife
    case motherOfWife
    case sonOfFatherOfWife
    case partnerOfSonOfFatherOfWife
    case daughterOfFatherOfWife
    case partnerOfDaughterOfFatherOfWife
//    case oldBrotherOfWife
//    case youngerBrotherOfWife
//    case oldSisterOfWife
//    case youngerSisterOfWife
//    case partnerOfOldBrotherOfWife
//    case partnerOfYoungerBrotherOfWife
//    case partnerOfOldSisterOfWife
//    case partnerOfYoungerSisterOfWife
    case sonOfFatherOfHusband
    case partnerOfSonOfFatherOfHusband
    case daughterOfFatherOfHusband
    case partnerOfDaughterOfFatherOfHusband
//    case oldBrotherOfHusband
//    case partnerOfOldBrotherOfHusband
//    case oldSisterOfHusband
//    case partnerOfOldSisterOfHusband
//    case youngerBrotherOfHusband
//    case partnerOfYoungerBrotherOfHusband
//    case youngerSisterOfHusband
//    case partnerOfYoungerSisterOfHusband
    case unknown
}

extension RelationshipInfoType {
    init?(_ relation: RelationshipInfoType,_ caseOfAdd: CaseOfAdd, from fromNode: Node, to toNode: Node) {
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
                self = .grandDaughter
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
                self = .grandDaughter
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
                self = .grandDaughter
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
                self = .grandDaughter
            }
        case .grandSon:
            self = .unknown
        case .grandDaughter:
            self = .unknown
        case .father:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfFather
            case .rightParent:
                self = .motherOfFather
            case .partner:
                self = .mother
            case .son:
                self = .sonOfParent
            case .daughter:
                self = .daughterOfParent
            }
        case .mother:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfMother
            case .rightParent:
                self = .motherOfMother
            case .partner:
                self = .father
            case .son:
                self = .sonOfParent
            case .daughter:
                self = .daughterOfParent
            }
        case .sonOfParent:
            switch caseOfAdd {
            case .leftParent:
                self = .father
            case .rightParent:
                self = .mother
            case .partner:
                self = .partnerOfSonOfParent
            case .son:
                self = .sonOfSonOfParent
            case .daughter:
                self = .daughterOfSonOfParent
            }
        case .partnerOfSonOfParent:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown

            case .partner:
                self = .sonOfParent
            case .son:
                self = .sonOfSonOfParent
            case .daughter:
                self = .daughterOfSonOfParent
            }
        case .sonOfSonOfParent:
            switch caseOfAdd {
            case .leftParent:
                self = .sonOfParent
            case .rightParent:
                self = .partnerOfSonOfParent
            case .partner:
                self = .partnerOfSonOfSonOfParent
            case .son:
                self = .childOfSonOfSonOfParent
            case .daughter:
                self = .childOfSonOfSonOfParent
            }
            
        case .partnerOfSonOfSonOfParent:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .sonOfSonOfParent
            case .son, .daughter:
                self = .childOfSonOfSonOfParent
            }
            
        case .childOfSonOfSonOfParent:
            switch caseOfAdd {
            case .leftParent:
                self = .sonOfSonOfParent
            case .rightParent:
                self = .partnerOfSonOfSonOfParent
            default:
                self = .unknown
            }
            
        case .daughterOfSonOfParent:
            switch caseOfAdd {
            case .leftParent:
                self = .sonOfParent
            case .rightParent:
                self = .partnerOfSonOfParent
            case .partner:
                self = .partnerOfDaughterOfSonOfParent
            case .son:
                self = .childOfDaughterOfSonOfParent
            case .daughter:
                self = .childOfDaughterOfSonOfParent
            }
            
        case .partnerOfDaughterOfSonOfParent:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
                
            case .partner:
                self = .daughterOfSonOfParent
                
            case .son, .daughter:
                self = .childOfDaughterOfSonOfParent
            }
            
        case .childOfDaughterOfSonOfParent:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfDaughterOfSonOfParent
                
            case .rightParent:
                self = .daughterOfSonOfParent
                
            default:
                self = .unknown
            }
            
        case .daughterOfParent:
            switch caseOfAdd {
            case .leftParent:
                self = .father
            case .rightParent:
                self = .mother
            case .partner:
                self = .partnerOfDaughterOfParent
            case .son:
                self = .sonOfDaughterOfParent
            case .daughter:
                self = .daughterOfDaughterOfParent
            }
            
        case .partnerOfDaughterOfParent:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .daughterOfParent
            case .son:
                self = .sonOfDaughterOfParent
            case .daughter:
                self = .daughterOfDaughterOfParent
            }
            
        case .sonOfDaughterOfParent:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfDaughterOfParent
            case .rightParent:
                self = .daughterOfParent
            case .partner:
                self = .partnerOfSonOfDaughterOfParent
            case .son, .daughter:
                self = .childOfSonOfDaughterOfParent
            }
        case .partnerOfSonOfDaughterOfParent:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .sonOfDaughterOfParent
            case .son, .daughter:
                self = .childOfSonOfDaughterOfParent
            }
            
        case .childOfSonOfDaughterOfParent:
            switch caseOfAdd {
            case .leftParent:
                self = .sonOfDaughterOfParent
            case .rightParent:
                self = .partnerOfSonOfDaughterOfParent
            default:
                self = .unknown
            }
            
        case .daughterOfDaughterOfParent:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfDaughterOfParent
            case .rightParent:
                self = .daughterOfParent
            case .partner:
                self = .partnerOfDaughterOfDaughterOfParent
            case .son, .daughter:
                self = .childOfDaughterOfDaughterOfParent
            }
            
        case .partnerOfDaughterOfDaughterOfParent:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .daughterOfDaughterOfParent
            case .son, .daughter:
                self = .childOfDaughterOfDaughterOfParent
            }
            
        case .childOfDaughterOfDaughterOfParent:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfDaughterOfDaughterOfParent
            case .rightParent:
                self = .daughterOfDaughterOfParent
            default:
                self = .unknown
            }
            
        case .fatherOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
                
            case .rightParent:
                self = .unknown
                
            case .partner:
                self = .motherOfFather
                
            case .son:
                self = .sonOfFatherOfFather
                
            case .daughter:
                self = .daughterOfFatherOfFather
            }
            
        case .motherOfFather:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
                
            case .partner:
                self = .fatherOfFather
                
            case .son:
                self = .sonOfFatherOfFather
                
            case .daughter:
                self = .daughterOfFatherOfFather
            }
            
        case .sonOfFatherOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfFather
            case .rightParent:
                self = .motherOfFather
            case .partner:
                self = .partnerOfSonOfFatherOfFather
            case .son:
                self = .sonOfSonOfFatherOfFather
            case .daughter:
                self = .daughterOfSonOfFatherOfFather
            }
            
        case .partnerOfSonOfFatherOfFather:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .sonOfFatherOfFather
            case .son:
                self = .sonOfSonOfFatherOfFather
            case .daughter:
                self = .daughterOfSonOfFatherOfFather
            }
            
        case .sonOfSonOfFatherOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .sonOfFatherOfFather
            case .rightParent:
                self = .partnerOfSonOfFatherOfFather
            case .partner:
                self = .partnerOfSonOfSonOfFatherOfFather
            default:
                self = .childOfSonOfSonOfFatherOfFather
            }
            
        case .partnerOfSonOfSonOfFatherOfFather:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .sonOfSonOfFatherOfFather
            default:
                self = .childOfSonOfSonOfFatherOfFather
            }
        case .childOfSonOfSonOfFatherOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .sonOfSonOfFatherOfFather
            case .rightParent:
                self = .partnerOfSonOfSonOfFatherOfFather
            default:
                self = .unknown
            }
            
        case .daughterOfSonOfFatherOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .sonOfFatherOfFather
            case .rightParent:
                self = .partnerOfSonOfFatherOfFather
            case .partner:
                self = .partnerOfDaughterOfSonOfFatherOfFather
            default:
                self = .childOfDaughterOfSonOfFatherOfFather
            }
            
        case .partnerOfDaughterOfSonOfFatherOfFather:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .daughterOfSonOfFatherOfFather
            default:
                self = .childOfDaughterOfSonOfFatherOfFather
            }
            
        case .childOfDaughterOfSonOfFatherOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfDaughterOfSonOfFatherOfFather
            case .rightParent:
                self = .daughterOfSonOfFatherOfFather
            default:
                self = .unknown
            }
            
        case .daughterOfFatherOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfFather
            case .rightParent:
                self = .motherOfFather
            case .partner:
                self = .partnerOfDaughterOfFatherOfFather
            case .son:
                self = .sonOfDaughterOfFatherOfFather
            case .daughter:
                self = .daughterOfDaughterOfFatherOfFather
            }
            
        case .partnerOfDaughterOfFatherOfFather:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .daughterOfFatherOfFather
            case .son:
                self = .sonOfDaughterOfFatherOfFather
            case .daughter:
                self = .daughterOfDaughterOfFatherOfFather
            }
            
        case .sonOfDaughterOfFatherOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfDaughterOfFatherOfFather
            case .rightParent:
                self = .daughterOfFatherOfFather
            case .partner:
                self = .partnerOfSonOfDaughterOfFatherOfFather
            default:
                self = .childOfSonOfDaughterOfFatherOfFather
            }
            
        case .partnerOfSonOfDaughterOfFatherOfFather:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .sonOfDaughterOfFatherOfFather
            default:
                self = .childOfSonOfDaughterOfFatherOfFather
            }
            
        case .childOfSonOfDaughterOfFatherOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .sonOfDaughterOfFatherOfFather
            case .rightParent:
                self = .partnerOfSonOfDaughterOfFatherOfFather
            default:
                self = .unknown
            }
            
        case .daughterOfDaughterOfFatherOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfDaughterOfFatherOfFather
            case .rightParent:
                self = .daughterOfFatherOfFather
            case .partner:
                self = .partnerOfDaughterOfDaughterOfFatherOfFather
            default:
                self = .childOfDaughterOfDaughterOfFatherOfFather
            }
            
        case .partnerOfDaughterOfDaughterOfFatherOfFather:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .daughterOfDaughterOfFatherOfFather
            default:
                self = .childOfDaughterOfDaughterOfFatherOfFather
            }
            
        case .childOfDaughterOfDaughterOfFatherOfFather:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfDaughterOfDaughterOfFatherOfFather
            case .rightParent:
                self = .daughterOfDaughterOfFatherOfFather
            default:
                self = .unknown
            }
            
        case .fatherOfMother:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .motherOfMother
            case .son:
                self = .sonOfFatherOfMother
            case .daughter:
                self = .daughterOfFatherOfMother
            }
            
        case .motherOfMother:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .fatherOfMother
            case .son:
                self = .sonOfFatherOfMother
            case .daughter:
                self = .daughterOfFatherOfMother
            }
            
        case .sonOfFatherOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfMother
            case .rightParent:
                self = .motherOfMother
            case .partner:
                self = .partnerOfSonOfFatherOfMother
            case .son:
                self = .sonOfSonOfFatherOfMother
            case .daughter:
                self = .daughterOfSonOfFatherOfMother
            }
            
        case .partnerOfSonOfFatherOfMother:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .sonOfFatherOfMother
            case .son:
                self = .sonOfSonOfFatherOfMother
            case .daughter:
                self = .daughterOfSonOfFatherOfMother
            }
            
        case .sonOfSonOfFatherOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .sonOfFatherOfMother
            case .rightParent:
                self = .partnerOfSonOfFatherOfMother
            case .partner:
                self = .partnerOfSonOfSonOfFatherOfMother
            case .son, .daughter:
                self = .childOfSonOfSonOfFatherOfMother
            }
            
        case .partnerOfSonOfSonOfFatherOfMother:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .sonOfSonOfFatherOfMother
            case .son, .daughter:
                self = .childOfSonOfSonOfFatherOfMother
            }
            
        case .childOfSonOfSonOfFatherOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .sonOfSonOfFatherOfMother
            case .rightParent:
                self = .partnerOfSonOfSonOfFatherOfMother
            default:
                self = .unknown
            }
            
        case .daughterOfSonOfFatherOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .sonOfFatherOfMother
            case .rightParent:
                self = .partnerOfSonOfFatherOfMother
            case .partner:
                self = .partnerOfDaughterOfSonOfFatherOfMother
            default:
                self = .childOfDaughterOfSonOfFatherOfMother
            }
            
        case .partnerOfDaughterOfSonOfFatherOfMother:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .daughterOfSonOfFatherOfMother
            default:
                self = .childOfDaughterOfSonOfFatherOfMother
            }
            
        case .childOfDaughterOfSonOfFatherOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfDaughterOfSonOfFatherOfMother
            case .rightParent:
                self = .daughterOfSonOfFatherOfMother
            default:
                self = .unknown
            }
            
        case .daughterOfFatherOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfMother
            case .rightParent:
                self = .motherOfMother
            case .partner:
                self = .partnerOfDaughterOfFatherOfMother
            case .son:
                self = .sonOfDaughterOfFatherOfMother
            case .daughter:
                self = .daughterOfDaughterOfFatherOfMother
            }
        case .partnerOfDaughterOfFatherOfMother:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .daughterOfFatherOfMother
            case .son:
                self = .sonOfDaughterOfFatherOfMother
            case .daughter:
                self = .daughterOfDaughterOfFatherOfMother
            }
        
        case .sonOfDaughterOfFatherOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfDaughterOfFatherOfMother
            case .rightParent:
                self = .daughterOfFatherOfMother
            case .partner:
                self = .partnerOfSonOfDaughterOfFatherOfMother
            case .son, .daughter:
                self = .childOfSonOfDaughterOfFatherOfMother
            }
            
        case .partnerOfSonOfDaughterOfFatherOfMother:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .sonOfDaughterOfFatherOfMother
            case .son, .daughter:
                self = .childOfSonOfDaughterOfFatherOfMother
            }
            
        case .childOfSonOfDaughterOfFatherOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .sonOfDaughterOfFatherOfMother
            case .rightParent:
                self = .partnerOfSonOfDaughterOfFatherOfMother
            default:
                self = .unknown
            }
            
        case .daughterOfDaughterOfFatherOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .partnerOfDaughterOfFatherOfMother
            case .rightParent:
                self = .daughterOfFatherOfMother
            case .partner:
                self = .partnerOfDaughterOfDaughterOfFatherOfMother
            case .son, .daughter:
                self = .childOfDaughterOfDaughterOfFatherOfMother
            }
        case .partnerOfDaughterOfDaughterOfFatherOfMother:
            switch caseOfAdd {
            case .leftParent, .rightParent:
                self = .unknown
            case .partner:
                self = .daughterOfDaughterOfFatherOfMother
            case .son, .daughter:
                self = .childOfDaughterOfDaughterOfFatherOfMother
            }
        case .childOfDaughterOfDaughterOfFatherOfMother:
            switch caseOfAdd {
            case .leftParent:
                self = .daughterOfDaughterOfFatherOfMother
            case .rightParent:
                self = .partnerOfDaughterOfDaughterOfFatherOfMother
            default:
                self = .unknown
            }
            
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
                self = .sonOfFatherOfHusband
            case .daughter:
                self = .daughterOfFatherOfHusband
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
                self = .sonOfFatherOfHusband
            case .daughter:
                self = .daughterOfFatherOfHusband
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
                self = .sonOfFatherOfWife
            case .daughter:
                self = .daughterOfFatherOfWife
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
                self = .sonOfFatherOfWife
            case .daughter:
                self = .daughterOfFatherOfWife
            }
                
        case .sonOfFatherOfWife:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfWife
            case .rightParent:
                self = .motherOfWife
            case .partner:
                self = .partnerOfSonOfFatherOfWife
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .daughterOfFatherOfWife:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfWife
            case .rightParent:
                self = .motherOfWife
            case .partner:
                self = .partnerOfDaughterOfFatherOfWife
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .partnerOfSonOfFatherOfWife:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .sonOfFatherOfWife
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .partnerOfDaughterOfFatherOfWife:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .daughterOfFatherOfWife
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .sonOfFatherOfHusband:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfHusband
            case .rightParent:
                self = .motherOfHusband
            case .partner:
                self = .partnerOfSonOfFatherOfHusband
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .partnerOfSonOfFatherOfHusband:
            switch caseOfAdd {
            case .leftParent:
                self = .unknown
            case .rightParent:
                self = .unknown
            case .partner:
                self = .sonOfFatherOfHusband
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .daughterOfFatherOfHusband:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfHusband
            case .rightParent:
                self = .motherOfHusband
            case .partner:
                self = .partnerOfDaughterOfFatherOfHusband
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .partnerOfDaughterOfFatherOfHusband:
            switch caseOfAdd {
            case .leftParent:
                self = .fatherOfHusband
            case .rightParent:
                self = .motherOfHusband
            case .partner:
                self = .daughterOfFatherOfHusband
            case .son:
                self = .unknown
            case .daughter:
                self = .unknown
            }
        case .unknown:
            self = .unknown

        }
    }
    
}


extension RelationshipInfoType {
    func getNicknames(to toNode: Node) async throws -> Nicknames {
//        guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
//        guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
//        guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
        switch self {
        case .me://
            return Nicknames(title: "나", nickname: "나")
        case .son://
            return Nicknames(title: "아들", nickname: "아들")
        case .daughter://
            return Nicknames(title: "딸", nickname: "딸")
        case .partnerOfSon://
            return Nicknames(title: "며느리", nickname: "며느리", leftParent: false, rightParent: false)
        case .partnerOfDaughter://
            return Nicknames(title: "사위", nickname: "사위", leftParent: false, rightParent: false)
        case .grandSon://
            return Nicknames(title: "손자", nickname: "손자", leftParent: false, rightParent: false, partner: false, son: false, daughter: false)
        case .grandDaughter://
            return Nicknames(title: "손녀", nickname: "손녀", leftParent: false, rightParent: false, partner: false, son: false, daughter: false)
        case .father://
            return Nicknames(title: "부", nickname: "아버지")
        case .mother://
            return Nicknames(title: "모", nickname: "어머니")
        case .sonOfParent://
            var title = "형제"
            var nickName = "형"
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            switch myNode.member.sex {
            case .female:
                title = "남매"
                if toNode.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "오빠"
                } else {
                    nickName = "남동생"
                }
            default:
                if toNode.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "형"
                } else {
                    nickName = "남동생"
                }
            }
            return Nicknames(title: title, nickname: nickName)
            
        case .partnerOfSonOfParent:
            var title = "형수"
            var nickName = "형수님"
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = toNode.partner else { throw ModumoaError.nodeIsNil }
            switch myNode.member.sex {
            case .female:
                title = "올케"
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "새언니"
                } else {
                    nickName = "올케"
                }
            default:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "형수님"
                } else {
                    title = "제수"
                    nickName = "제수씨"
                }
            }
            return Nicknames(title: title, nickname: nickName, leftParent: false, rightParent: false)
            
        case .sonOfSonOfParent:
            return Nicknames(title: "질", nickname: "조카")
            
        case .partnerOfSonOfSonOfParent:
            return Nicknames(title: "질부", nickname: "조카며느리", leftParent: false, rightParent: false)
            
        case .childOfSonOfSonOfParent:
            return Nicknames(title: "질손자녀", nickname: "이손자/이손녀", leftParent: false, rightParent: false, partner: false, son: false, daughter: false)
            
        case .daughterOfSonOfParent:
            return Nicknames(title: "질녀", nickname: "조카")
            
        case .partnerOfDaughterOfSonOfParent:
            return Nicknames(title: "질서", nickname: "조카사위", leftParent: false, rightParent: false)
            
        case .childOfDaughterOfSonOfParent:
            return Nicknames(title: "질손자녀", nickname: "이손자/이손녀", leftParent: false, rightParent: false, partner: false, son: false, daughter: false)
            
        case .daughterOfParent:
            var title = "자매"
            var nickName = "언니"
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            switch myNode.member.sex {
            case .female:
                if toNode.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "연니"
                } else {
                    nickName = "여동생"
                }
            default:
                title = "남매"
                if toNode.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "누나"
                } else {
                    nickName = "여동생"
                }
            }
            return Nicknames(title: title, nickname: nickName)
            
        case .partnerOfDaughterOfParent:
            var title = "매형"
            var nickName = "매형"
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = toNode.partner else { throw ModumoaError.nodeIsNil }
            switch myNode.member.sex {
            case .female:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    title = "형부"
                    nickName = "형부"
                } else {
                    title = "제부"
                    nickName = "제부"
                }
            default:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "매형"
                } else {
                    title = "매부"
                    nickName = "매제"
                }
            }
            return Nicknames(title: title, nickname: nickName, leftParent: false, rightParent: false)
            
        case .sonOfDaughterOfParent:
            return Nicknames(title: "생질", nickname: "조카")
            
        case .partnerOfSonOfDaughterOfParent:
            return Nicknames(title: "생질부", nickname: "조카며느리", leftParent: false, rightParent: false)
            
        case .childOfSonOfDaughterOfParent:
            return Nicknames(title: "생질손자녀", nickname: "종손자/종손녀", leftParent: false, rightParent: false, partner: false, son: false, daughter: false)
            
        case .daughterOfDaughterOfParent:
            return Nicknames(title: "생질녀", nickname: "조카")
            
        case .partnerOfDaughterOfDaughterOfParent:
            return Nicknames(title: "생질서", nickname: "조카사위", leftParent: false, rightParent: false)
            
        case .childOfDaughterOfDaughterOfParent:
            return Nicknames(title: "생질손자녀", nickname: "종손자/종손녀", leftParent: false, rightParent: false, partner: false, son: false, daughter: false)
            
        case .fatherOfFather:
            return Nicknames(title: "조부", nickname: "할아버지", leftParent: false, rightParent: false)
            
        case .motherOfFather:
            return Nicknames(title: "조모", nickname: "할머니", leftParent: false, rightParent: false)
            
        case .sonOfFatherOfFather:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let father = myNode.leftParent else { throw ModumoaError.nodeIsNil }
            var title = "백부"
            var nickName = "큰아버지"
            if toNode.member.birthday ?? Date() >= father.member.birthday ?? Date() {
                title = "숙부"
                nickName = "작은아버지"
            }
            return Nicknames(title: title, nickname: nickName)
            
        case .partnerOfSonOfFatherOfFather:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let father = myNode.leftParent else { throw ModumoaError.nodeIsNil }
            guard let partner = toNode.partner else { throw ModumoaError.nodeIsNil }
            var title = "백모"
            var nickName = "큰어머니"
            if partner.member.birthday ?? Date() >= father.member.birthday ?? Date() {
                title = "숙모"
                nickName = "작은어머니"
            }
            return Nicknames(title: title, nickname: nickName, leftParent: false, rightParent: false)
            
        case .sonOfSonOfFatherOfFather:
            return Nicknames(title: "종형제", nickname: "사촌형제")
            
        case .partnerOfSonOfSonOfFatherOfFather:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = toNode.partner else { throw ModumoaError.nodeIsNil }
            var title = "종수"
            var nickName = ""
            switch myNode.member.sex {
            case .female:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "새언니"
                } else {
                    nickName = "올케"
                }
            default:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "형수님"
                } else {
                    nickName = "제수씨"
                }
            }
            return Nicknames(title: title, nickname: nickName, leftParent: false, rightParent: false)
            
        case .childOfSonOfSonOfFatherOfFather:
            return Nicknames(title: "종질/당질", nickname: "사촌조카", leftParent: false, rightParent: false, partner: false, son: false, daughter: false)
            
        case .daughterOfSonOfFatherOfFather:
            return Nicknames(title: "종형제", nickname: "사촌형제")
            
        case .partnerOfDaughterOfSonOfFatherOfFather:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = toNode.partner else { throw ModumoaError.nodeIsNil }
            var title = "종수"
            var nickName = ""
            switch myNode.member.sex {
            case .female:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "형부"
                } else {
                    nickName = "제부"
                }
            default:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "매형"
                } else {
                    nickName = "매제"
                }
            }
            return Nicknames(title: title, nickname: nickName, leftParent: false, rightParent: false)
            
        case .childOfDaughterOfSonOfFatherOfFather:
            return Nicknames(title: "종질/당질", nickname: "사촌조카", leftParent: false, rightParent: false, partner: false, son: false, daughter: false)
            
        case .daughterOfFatherOfFather:
            return Nicknames(title: "고모", nickname: "고모")
            
        case .partnerOfDaughterOfFatherOfFather:
            return Nicknames(title: "고모부", nickname: "고모부", leftParent: false, rightParent: false)
        
        case .sonOfDaughterOfFatherOfFather:
            return Nicknames(title: "내종형제", nickname: "사촌형제")
            
        case .partnerOfSonOfDaughterOfFatherOfFather:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = toNode.partner else { throw ModumoaError.nodeIsNil }
            var title = "내종수"
            var nickName = ""
            switch myNode.member.sex {
            case .female:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "새언니"
                } else {
                    nickName = "올케"
                }
            default:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "형수님"
                } else {
                    nickName = "제수씨"
                }
            }
            return Nicknames(title: title, nickname: nickName, leftParent: false, rightParent: false)
            
        case .childOfSonOfDaughterOfFatherOfFather:
            return Nicknames(title: "내재종손", nickname: "내재종손", leftParent: false, rightParent: false, partner: false, son: false, daughter: false)
            
        case .daughterOfDaughterOfFatherOfFather:
            return Nicknames(title: "내종형제", nickname: "사촌형제")
            
        case .partnerOfDaughterOfDaughterOfFatherOfFather:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = toNode.partner else { throw ModumoaError.nodeIsNil }
            var title = "내종수"
            var nickName = ""
            switch myNode.member.sex {
            case .female:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "형부"
                } else {
                    nickName = "제부"
                }
            default:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "매형"
                } else {
                    nickName = "매제"
                }
            }
            return Nicknames(title: title, nickname: nickName, leftParent: false, rightParent: false)
            
        case .childOfDaughterOfDaughterOfFatherOfFather:
            return Nicknames(title: "내재종손", nickname: "내재종손", leftParent: false, rightParent: false, partner: false, son: false, daughter: false)
            
        
//        case .childOfChildOfChildOfBrotherOfFather://
//            Nicknames(title: "재종손", nickname: "재종손", leftParent: false, rightParent: false, partner: false, son: false, daughter: false)
        
        case .fatherOfMother://
            return Nicknames(title: "외조부", nickname: "외할아버지", leftParent: false, rightParent: false)
        case .motherOfMother://
            return Nicknames(title: "외조모", nickname: "외할머니", leftParent: false, rightParent: false)
        case .sonOfFatherOfMother://
            return Nicknames(title: "외숙", nickname: "외삼촌")
            
        case .partnerOfSonOfFatherOfMother:
            return Nicknames(title: "외숙모", nickname: "외숙모", leftParent: false, rightParent: false)
        
        case .sonOfSonOfFatherOfMother:
            return Nicknames(title: "외종형제", nickname: "외사촌")
        case .partnerOfSonOfSonOfFatherOfMother:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = toNode.partner else { throw ModumoaError.nodeIsNil }
            var title = "외종수"
            var nickName = ""
            switch myNode.member.sex {
            case .female:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "새언니"
                } else {
                    nickName = "올케"
                }
            default:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "형수님"
                } else {
                    nickName = "제수씨"
                }
            }
            return Nicknames(title: title, nickname: nickName, leftParent: false, rightParent: false)
            
        case .childOfSonOfSonOfFatherOfMother:
            return Nicknames(title: "외종질", nickname: "외사촌조카", leftParent: false, rightParent: false, partner: false, son: false, daughter: false)
            
        case .daughterOfSonOfFatherOfMother:
            return Nicknames(title: "외종형제", nickname: "외사촌")
            
        case .partnerOfDaughterOfSonOfFatherOfMother:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = toNode.partner else { throw ModumoaError.nodeIsNil }
            var title = "외종수"
            var nickName = ""
            switch myNode.member.sex {
            case .female:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "형부"
                } else {
                    nickName = "제부"
                }
            default:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "매형"
                } else {
                    nickName = "매제"
                }
            }
            return Nicknames(title: title, nickname: nickName, leftParent: false, rightParent: false)
            
        case .childOfDaughterOfSonOfFatherOfMother:
            return Nicknames(title: "외종질", nickname: "외사촌조카", leftParent: false, rightParent: false, partner: false, son: false, daughter: false)
            
        case .daughterOfFatherOfMother:
            return Nicknames(title: "이모", nickname: "이모")
            
        case .partnerOfDaughterOfFatherOfMother:
            return Nicknames(title: "이모부", nickname: "이모부", leftParent: false, rightParent: false)
            
        case .sonOfDaughterOfFatherOfMother:
            return Nicknames(title: "외종형제", nickname: "외사촌")
        case .partnerOfSonOfDaughterOfFatherOfMother:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = toNode.partner else { throw ModumoaError.nodeIsNil }
            var title = "이종수"
            var nickName = ""
            switch myNode.member.sex {
            case .female:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "새언니"
                } else {
                    nickName = "올케"
                }
            default:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "형수님"
                } else {
                    nickName = "제수씨"
                }
            }
            return Nicknames(title: title, nickname: nickName, leftParent: false, rightParent: false)
            
        case .childOfSonOfDaughterOfFatherOfMother:
            return Nicknames(title: "외종질", nickname: "외사촌조카", leftParent: false, rightParent: false, partner: false, son: false, daughter: false)
            
        case .daughterOfDaughterOfFatherOfMother:
            return Nicknames(title: "외종형제", nickname: "외사촌")
            
        case .partnerOfDaughterOfDaughterOfFatherOfMother:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = toNode.partner else { throw ModumoaError.nodeIsNil }
            var title = "이종수"
            var nickName = ""
            switch myNode.member.sex {
            case .female:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "형부"
                } else {
                    nickName = "제부"
                }
            default:
                if partner.member.birthday ?? Date() < myNode.member.birthday ?? Date() {
                    nickName = "매형"
                } else {
                    nickName = "매제"
                }
            }
            return Nicknames(title: title, nickname: nickName, leftParent: false, rightParent: false)
            
        case .childOfDaughterOfDaughterOfFatherOfMother:
            return Nicknames(title: "외종질", nickname: "외사촌조카", leftParent: false, rightParent: false, partner: false, son: false, daughter: false)
            
//        case .childOfChildOfChildOfBrotherOfMother://
//            Nicknames(title: "외재종손", nickname: "외재종손", leftParent: false, rightParent: false, partner: false, son: false, daughter: false)
        case .wife://
            return Nicknames(title: "아내", nickname: "아내")
        case .husband://
            return Nicknames(title: "남편", nickname: "남편")
        case .fatherOfHusband://
            return Nicknames(title: "시부모", nickname: "시아버지", leftParent: false, rightParent: false)
        case .motherOfHusband://
            return Nicknames(title: "시부모", nickname: "시어머니", leftParent: false, rightParent: false)
        case .fatherOfWife://
            return Nicknames(title: "장인", nickname: "장인어른", leftParent: false, rightParent: false)
        case .motherOfWife://
            return Nicknames(title: "장모", nickname: "장모님", leftParent: false, rightParent: false)
        case .sonOfFatherOfWife:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = myNode.partner else { throw ModumoaError.nodeIsNil }
            var title = "처남"
            var nickName = "처남"
            if toNode.member.birthday ?? Date() < partner.member.birthday ?? Date() {
                title = "손윗처남"
                nickName = "형님"
            }
            return Nicknames(title: title, nickname: nickName, son: false, daughter: false)
            
        case .partnerOfSonOfFatherOfWife:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = myNode.partner else { throw ModumoaError.nodeIsNil }
            var title = "처남댁"
            var nickName = "처남댁"
            if toNode.member.birthday ?? Date() < partner.member.birthday ?? Date() {
                title = "손윗처남댁"
                nickName = "아주머니"
            }
            return Nicknames(title: title, nickname: nickName, leftParent: false, rightParent: false, son: false, daughter: false)
            
        case .daughterOfFatherOfWife:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = myNode.partner else { throw ModumoaError.nodeIsNil }
            var title = "처제"
            var nickName = "처제"
            if toNode.member.birthday ?? Date() < partner.member.birthday ?? Date() {
                title = "처형"
                nickName = "처형"
            }
            return Nicknames(title: title, nickname: nickName, leftParent: false, rightParent: false, son: false, daughter: false)
            
        case .partnerOfDaughterOfFatherOfWife:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = myNode.partner else { throw ModumoaError.nodeIsNil }
            var title = "동서"
            var nickName = "동서"
            if toNode.member.birthday ?? Date() < partner.member.birthday ?? Date() {
                title = "손윗동서"
                nickName = "형님"
            }
            return Nicknames(title: title, nickname: nickName, leftParent: false, rightParent: false, son: false, daughter: false)
            
        case .sonOfFatherOfHusband:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = myNode.partner else { throw ModumoaError.nodeIsNil }
            var title = "시동생"
            var nickName = "도련님"
            if toNode.member.birthday ?? Date() < partner.member.birthday ?? Date() {
                title = "시아주버님"
                nickName = "아주버님"
            }
            return Nicknames(title: title, nickname: nickName, son: false, daughter: false)
            
        case .partnerOfSonOfFatherOfHusband:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = myNode.partner else { throw ModumoaError.nodeIsNil }
            var title = "동서"
            var nickName = "동서"
            if toNode.member.birthday ?? Date() < partner.member.birthday ?? Date() {
                title = "손윗동서"
                nickName = "형님"
            }
            return Nicknames(title: title, nickname: nickName, leftParent: false, rightParent: false, son: false, daughter: false)
            
        case .daughterOfFatherOfHusband:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = myNode.partner else { throw ModumoaError.nodeIsNil }
            var title = "시누이"
            var nickName = "아가씨"
            if toNode.member.birthday ?? Date() < partner.member.birthday ?? Date() {
                title = "시누이"
                nickName = "형님"
            }
            return Nicknames(title: title, nickname: nickName, daughter: false)
            
        case .partnerOfDaughterOfFatherOfHusband:
            guard let stringID = UserDefaults.standard.myNodeID else { throw ModumoaError.myNodeIdError }
            guard let id = UUID(uuidString: stringID) else { throw ModumoaError.uuidError }
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { throw ModumoaError.notFound }
            guard let partner = myNode.partner else { throw ModumoaError.nodeIsNil }
            var title = "시매부"
            var nickName = "시매부"
            if toNode.member.birthday ?? Date() < partner.member.birthday ?? Date() {
                title = "시자부"
                nickName = "아주버님"
            }
            return Nicknames(title: title, nickname: nickName, leftParent: false, rightParent: false, son: false, daughter: false)
            
        case .unknown:
            return Nicknames(title: "모름", nickname: "모름")
        }
    }
}
