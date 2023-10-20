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

enum Sex {
    case male
    case female
}

struct BloodType {
    
    enum AboType {
        case A
        case B
        case O
        case AB
    }
    
    enum RhType: String {
        case positive = "+"
        case negative = "-"
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
