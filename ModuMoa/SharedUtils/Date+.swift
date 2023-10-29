//
//  Date+.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/28/23.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.locale = Locale(identifier: "ko-kr")
        
        let result = dateFormatter.string(from: self)
        return result
    }
}
