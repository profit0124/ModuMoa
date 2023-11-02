//
//  Font+.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/25/23.
//

import SwiftUI
import UIKit

extension Font {
    enum CustomFont {
        case body
        case callOut
        case caption1
        case caption2
        case footnote
        case headline
        case largeTitle
        case subHeadline
        case title1
        case title2
        case title3
    }
    
    static func customFont(_ font: CustomFont) -> Font {
        switch font {
        case .body:
            return Font.custom("SF Pro Text Medium", size: 17)
        case .callOut:
            return Font.custom("SF Pro Text Medium", size: 16)
        case .caption1:
            return Font.custom("SF Pro Text Medium", size: 12)
        case .caption2:
            return Font.custom("SF Pro Text Medium", size: 11)
        case .footnote:
            return Font.custom("SF Pro Text Medium", size: 13)
        case .headline:
            return Font.custom("SF Pro Text Semibold", size: 17)
        case .largeTitle:
            return Font.custom("SF Pro Text Regular", size: 34)
        case .subHeadline:
            return Font.custom("SF Pro Text Medium", size: 15)
        case .title1:
            return Font.custom("SF Pro Text Regular", size: 28)
        case .title2:
            return Font.custom("SF Pro Text Medium", size: 22)
        case .title3:
            return Font.custom("SF Pro Text Medium", size: 20)
        }
    }
}
