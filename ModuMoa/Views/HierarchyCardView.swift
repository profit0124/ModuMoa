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
                    cardViewWithButton(viewStore.node, viewStore: viewStore) { member in
                        print("add my parents or children")
                    }
                        .frame(width: 250)
                        .anchorPreference(key: Key.self, value: .center, transform: { anchor in
                            return [viewStore.node.member.id:anchor]
                        })
                    
                    if let partner = viewStore.node.partner {
                        cardViewWithButton(partner, viewStore: viewStore) { _ in
                            print("add partner's parents or children")
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
                }
            }
            .onAppear {
                self.me = viewStore.node.member.id
                viewStore.send(.viewOnAppear)
            }
            .onChange(of: viewStore.node.partner, {
                self.partner = viewStore.node.partner?.id
            })
            .onChange(of: viewStore.children, {
                self.childrens = viewStore.children.map { $0.node.member.id }
            })
            .frame(alignment: .top)
            .backgroundPreferenceValue(Key.self) { value in
                GeometryReader { proxy in
                    if let me, let myValue = value[me] {
                        if let myPoint: CGPoint = proxy[myValue] as? CGPoint {
                            if let partner = partner, let partnerValue = value[partner], let endPoint: CGPoint =  proxy[partnerValue] as? CGPoint {
                                Line(startPoint: myPoint, endPoint: endPoint)
                                    .stroke(lineWidth: 2)
                                    .fill(.moduBlack)
                            }
                            let middleOfParents = partner == nil ? myPoint : self.middleOfPoints(myPoint, proxy[value[partner!] ?? myValue])
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
    }
    
    private func middleOfPoints(_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        let x = (lhs.x + rhs.x) / 2
        let y = (lhs.y + rhs.y) / 2
        return CGPoint(x: x, y: y)
    }
    
    @ViewBuilder
    private func cardViewWithButton(_ node: Node, viewStore: ViewStoreOf<HierarchyCard>, completion: @escaping (Member) -> Void) -> some View {
        VStack {
            CardView(member: node.member, store: StoreOf<Card>(initialState: Card.State(member: node.member)) { Card() })
                .onTapGesture {
                    viewStore.send(.selectNode(node))
                }
            Button(action: {
                let member = Member(name: "Children", bloodType: .init(abo: .A, rh: .negative), sex: .female, birthday: Date())
                completion(member)
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
