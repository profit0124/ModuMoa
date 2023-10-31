//
//  Member.swift
//  ModuMoa
//
//  Created by KiWoong Hong on 2023/10/14.
//

import Foundation

struct Member: Identifiable {
    
    
    let id: UUID = UUID()
    var name: String
    var bloodType: BloodType
    var sex: Sex
    var birthday: Date
    
    func isMale() -> Bool {
        return sex == .male
    }
    
    func age() -> String {
        let ageComponent = Calendar.current.dateComponents([.year], from: birthday, to: Date())
        let age = ageComponent.year ?? 0
        return "만 \(age)세"
    }
}

enum Sex {
    case male
    case female
}

struct BloodType {
    
    enum AboType: String {
        case A = "A형"
        case B = "B형"
        case O = "O형"
        case AB = "AB형"
        case none = "none"
    }
    
    enum RhType: String {
        case positive = "Rh+"
        case negative = "Rh-"
        case none = " "
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
