//
//  HierarchyCardView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/21/23.
//

import SwiftUI

struct HierarchyCardView: View {
    
    @State private var vm: HierarchyCardViewModel
    @Environment(\.isNoSafeAreaDevice) var isNoSafeArea
    @Environment(ModumoaRouter.self) var coordinator
    
    init(node: Node) {
        self._vm = .init(initialValue: .init(node: node))
    }
    
    typealias Key = PreferKey<Member.ID, Anchor<CGPoint>>

    var body: some View {
        VStack(spacing: 80) {
            HStack(spacing: 20) {
                CardWithButtonView(node: vm.node)
                    .frame(width: 250)
                    .anchorPreference(key: Key.self, value: .center, transform: { anchor in
                        return [vm.node.id:anchor]
                    })
                
                if let partner = vm.node.partner {
                    CardWithButtonView(node: partner)
                        .frame(width: 250)
                        .anchorPreference(key: Key.self, value: .center, transform: { anchor in
                            return [partner.id:anchor]
                        })
                }
            }
            
            HStack(alignment: .top, spacing: 80) {
                ForEach(vm.orderedChildren, id: \.id) { children in
                    HierarchyCardView(node: children)
                }
            }
        }
        .frame(alignment: .top)
        .backgroundPreferenceValue(Key.self) { value in
            GeometryReader { proxy in
                if let myValue = value[self.vm.node.id] {
                    let myPoint: CGPoint = proxy[myValue]
                    if let partner = self.vm.node.partner, let partnerValue = value[partner.id] {
                        let endPoint: CGPoint =  proxy[partnerValue]
                        Line(startPoint: myPoint, endPoint: endPoint)
                            .stroke(lineWidth: 2)
                            .fill(.moduBlack)
                    }
                    let middleOfParents = vm.node.partner == nil ? myPoint : self.middleOfPoints(myPoint, proxy[value[self.vm.node.partner!.id] ?? myValue])
                    ForEach(vm.node.children, id: \.self) { children in
                        let endPoint = value[children.id] == nil ? middleOfParents : proxy[value[children.id]!]
                        Line(startPoint: middleOfParents, endPoint: endPoint)
                            .stroke(lineWidth: 2)
                            .fill(.moduBlack)
                        
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
}


