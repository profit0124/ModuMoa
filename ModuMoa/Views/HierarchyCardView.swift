//
//  HierarchyCardView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/21/23.
//

import SwiftUI
import ComposableArchitecture

struct HierarchyCardView: View {
    
    let store: StoreOf<HierarchyCard>
    @State var me: Member.ID?
    @State var partner: Member.ID?
    @State var childrens: [Member.ID]?
    
    typealias Key = PreferKey<Member.ID, Anchor<CGPoint>>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 80) {
                HStack(spacing: 20) {
                    cardViewWithButton(viewStore.me) { member in
                        if viewStore.partner == nil {
                            viewStore.send(.addPartner)
                        } else {
                            viewStore.send(.addChildren(member))
                        }
                        
                    }
                        .frame(width: 250)
                        .anchorPreference(key: Key.self, value: .center, transform: { anchor in
                            return [viewStore.me.id:anchor]
                        })
                    
                    if let partner = viewStore.partner {
                        cardViewWithButton(partner) { _ in
                            
                        }
                            .frame(width: 250)
                            .anchorPreference(key: Key.self, value: .center, transform: { anchor in
                                return [partner.id:anchor]
                            })
                        
                    }
                }
                
                HStack(alignment: .top, spacing: 80) {
                    ForEachStore(self.store.scope(state: \.children, action: HierarchyCard.Action.children(id: action:)), content: {
                        HierarchyCardView(store: $0)
                    })
//                    ForEach(childrens, id: \.id) { children in
//                        HierarchyCardView(me: children)
//                    }
                }
            }
            .onAppear {
                self.me = viewStore.me.id
                viewStore.send(.viewOnAppear)
            }
            .onChange(of: viewStore.partner, {
                self.partner = viewStore.partner?.id
            })
            .onChange(of: viewStore.children, {
                self.childrens = viewStore.children.map { $0.me.id }
            })
            .frame(alignment: .top)
            .backgroundPreferenceValue(Key.self) { value in
                GeometryReader { proxy in
                    if let me {
                        let myPoint: CGPoint = proxy[value[me]!]
                        if let partner = partner {
                            Line(startPoint: myPoint, endPoint: proxy[value[partner]!])
                                .stroke(lineWidth: 2)
                                .fill(.moduBlack)
                        }
                        let middleOfParents = partner == nil ? myPoint : self.middleOfPoints(myPoint, proxy[value[partner!]!])
                        if let childrens {
                            ForEach(childrens, id: \.self) { children in
                                Line(startPoint: middleOfParents, endPoint: proxy[value[children]!])
                                    .stroke(lineWidth: 2)
                                    .fill(.moduBlack)
                            }
                        }
                    }
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
    private func cardViewWithButton(_ member: Member, completion: @escaping (Member) -> Void) -> some View {
        VStack {
            CardView(member: member, store: StoreOf<Card>(initialState: Card.State(member: member)) { Card() })
            Button(action: {
                let member = Member(name: "Children", bloodType: .init(abo: .A, rh: .negative), sex: .female, birthday: Date())
//                viewStore.send(.addChildren(member))
                completion(member)
//                childrens.append(member)
//                index += 1
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
//#Preview {
//    HierarchyCardView(me: Member(name: "Kim", bloodType: .init(abo: .A, rh: .positive), sex: .male, birthday: Date()), partner: Member(name: "Partner", bloodType: .init(abo: .A, rh: .negative), sex: .female, birthday: Date()))
//}


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
