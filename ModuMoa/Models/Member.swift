//
//  Member.swift
//  ModuMoa
//
//  Created by KiWoong Hong on 2023/10/14.
//

import Foundation

struct Member: Identifiable, Equatable, Hashable {
//    static func == (lhs: Member, rhs: Member) -> Bool {
//        return lhs.id == rhs.id
//    }

    let id: UUID = UUID()
    var name: String
    var bloodType: BloodType
    var sex: Sex
    var birthday: Date?
    var nickName: String = ""
    
    func isMale() -> Bool {
        return sex == .male
    }
    
    func age() -> String {
        guard let birthday = birthday else { return "만 ??세" }
        let ageComponent = Calendar.current.dateComponents([.year], from: birthday, to: Date())
        let age = ageComponent.year ?? 0
        return "만 \(age)세"
    }
}

enum Sex: String, CaseIterable, Equatable, Hashable {
    case male = "남성"
    case female = "여성"
    case none = "모름"
}

struct BloodType: Equatable, Hashable {
    
    enum AboType: String, CaseIterable, Equatable, Hashable {
        case A = "A형"
        case B = "B형"
        case O = "O형"
        case AB = "AB형"
        case none = "모름"
    }
    
    enum RhType: String, CaseIterable, Equatable, Hashable {
        case positive = "Rh+"
        case negative = "Rh-"
        case none = "모름"
    }
    
    var abo: AboType
    var rh: RhType
    
}

extension String {
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        guard let date = dateFormatter.date(from: self) else { return nil }
        
        return date
    }
}
