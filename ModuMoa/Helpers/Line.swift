//
//  Line.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/21/24.
//

import SwiftUI

struct Line: Shape {
    var startPoint: CGPoint
    var endPoint: CGPoint
    var animatableData: AnimatablePair<CGPoint.AnimatableData, CGPoint.AnimatableData> {
        get { AnimatablePair(startPoint.animatableData, endPoint.animatableData) }
        set { (startPoint.animatableData, endPoint.animatableData) = (newValue.first, newValue.second) }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: self.startPoint)
            if startPoint.y != endPoint.y, startPoint.x != endPoint.x {
                let middleOfY = (endPoint.y - startPoint.y) / 1.3
                let firstCornerPoint = CGPoint(x: startPoint.x, y: middleOfY)
                let secondCornerPoint = CGPoint(x: endPoint.x, y: middleOfY)
                p.addLine(to: firstCornerPoint)
                p.addLine(to: secondCornerPoint)
            }
            p.addLine(to: self.endPoint)
        }
    }
}

