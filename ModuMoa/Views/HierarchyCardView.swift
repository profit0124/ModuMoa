//
//  HierarchyCardView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/21/23.
//

import SwiftUI
import ComposableArchitecture

struct HierarchyCardView: View {
    
    @State var me: Member
    @State var partner: Member?
    @State var childrens:[Member] = []
    @State var index:Int = 0
    
    typealias Key = PreferKey<Member.ID, Anchor<CGPoint>>

    var body: some View {
        VStack(spacing: 80) {
            HStack(spacing: 20) {
                cardViewWithButton(me)
                    .frame(width: 250)
                    .anchorPreference(key: Key.self, value: .center, transform: { anchor in
                        return [self.me.id:anchor]
                    })
                
                if let partner {
                    cardViewWithButton(partner)
                        .frame(width: 250)
                        .anchorPreference(key: Key.self, value: .center, transform: { anchor in
                            return [partner.id:anchor]
                        })
                    
                }
            }
            
            HStack(alignment: .top, spacing: 80) {
                ForEach(childrens, id: \.id) { children in
                    HierarchyCardView(me: children)
                }
            }
        }
        .frame(alignment: .top)
        .backgroundPreferenceValue(Key.self) { value in
            GeometryReader { proxy in
                let myPoint: CGPoint = proxy[value[self.me.id]!]
                if let partner = self.partner {
                    Line(startPoint: myPoint, endPoint: proxy[value[partner.id]!])
                        .stroke(lineWidth: 2)
                        .fill(.moduBlack)
                }
                let middleOfParents = self.partner == nil ? myPoint : self.middleOfPoints(myPoint, proxy[value[self.partner!.id]!])
                ForEach(childrens, id: \.id) { children in
                    Line(startPoint: middleOfParents, endPoint: proxy[value[children.id]!])
                        .stroke(lineWidth: 2)
                        .fill(.moduBlack)
                }
            }
        }
    }
    
    private func middleOfPoints(_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        let x = (lhs.x + rhs.x) / 2
        let y = (lhs.y + rhs.y) / 2
        return CGPoint(x: x, y: y)
    }
    
    @ViewBuilder
    private func cardViewWithButton(_ member: Member) -> some View {
        VStack {
            CardView(member: member, store: StoreOf<Card>(initialState: Card.State(member: member)) { Card() })
            Button(action: {
                let member = Member(name: "Children\(index)", bloodType: .init(abo: .A, rh: .negative), sex: .female, birthday: Date())
                childrens.append(member)
                index += 1
            }, label: {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                    .padding(4)
                    .background{
                        Circle()
                            .fill(.disableText)
                    }
            })
        }
    }
}
#Preview {
    HierarchyCardView(me: Member(name: "Kim", bloodType: .init(abo: .A, rh: .positive), sex: .male, birthday: Date()), partner: Member(name: "Partner", bloodType: .init(abo: .A, rh: .negative), sex: .female, birthday: Date()))
}


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

struct PreferKey<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key: Value] { [:] }
    static func reduce(value: inout [Key: Value], nextValue: () -> [Key: Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}
