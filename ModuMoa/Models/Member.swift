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
}

enum Sex: String, CaseIterable {
    case male = "남성"
    case female = "여성"
}

struct BloodType {
    
    enum AboType: String, CaseIterable {
        case A = "A형"
        case B = "B형"
        case O = "O형"
        case AB = "AB형"
    }
    
    enum RhType: String, CaseIterable {
        case positive = "Rh+"
        case negative = "Rh-"
    }
    
    var abo: AboType
    var rh: RhType
    
}

extension String {
    
    func toDate() -> Date? { //"yyyyMMdd"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        guard let date = dateFormatter.date(from: self) else { return nil }
        
        return date
    }
}
