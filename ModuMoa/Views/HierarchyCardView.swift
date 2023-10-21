//
//  HierarchyCardView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/21/23.
//

import SwiftUI

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
                
                if let partner {
                    cardViewWithButton(partner)
                        .frame(width: 250)
                }
            }
            .anchorPreference(key: Key.self, value: .center, transform: { anchor in
                [self.me.id:anchor]
            })
            
            HStack(alignment: .top) {
                ForEach(childrens, id: \.id) { children in
                    HierarchyCardView(me: children)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(alignment: .top)
        .backgroundPreferenceValue(Key.self) { value in
            GeometryReader { proxy in
                ForEach(childrens, id: \.id) { children in
                    Line(startPoint: proxy[value[self.me.id]!], endPoint: proxy[value[children.id]!])
                        .stroke(lineWidth: 2)
                        .fill(.moduBlack)
                }
            }
        }
    }
    
    @ViewBuilder
    private func cardViewWithButton(_ member: Member) -> some View {
        VStack {
            CardView(name: member.name)
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
                let middleOfY = (endPoint.y - startPoint.y) / 2
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
