//
//  HierarchyCardView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/21/23.
//

import SwiftUI

struct HierarchyCardView: View {
    
    @Binding var node: Node
    @State private var isPresented: Bool = false
    @State private var selectedAddCase: CaseOfAdd?
    @State private var addNodeViewisPushed: Bool = false
    @State private var detailNodeViewisPushed: Bool = false
    // 추가 Sheet 가 내 카드에서 + 인지, 아님 파트너의 + 인지 구별하기 위함
    @State private var fromMe: Bool = true
    
//    let afterAddAction: (Node) -> Void
    
    typealias Key = PreferKey<Member.ID, Anchor<CGPoint>>

    var body: some View {
        VStack(spacing: 80) {
            HStack(spacing: 20) {
                cardViewWithButton(node)
                    .frame(width: 250)
                    .anchorPreference(key: Key.self, value: .center, transform: { anchor in
                        return [node.id:anchor]
                    })
                
                if let partner = node.partner {
                    cardViewWithButton(partner)
                        .frame(width: 250)
                        .anchorPreference(key: Key.self, value: .center, transform: { anchor in
                            return [partner.id:anchor]
                        })
                    
                }
            }
            
            HStack(alignment: .top, spacing: 80) {
                ForEach($node.children, id: \.id) { $children in
                    HierarchyCardView(node: $children)
                }
            }
        }
        .frame(alignment: .top)
        .backgroundPreferenceValue(Key.self) { value in
            GeometryReader { proxy in
                if let myValue = value[self.node.id] {
                    let myPoint: CGPoint = proxy[myValue]
                    if let partner = self.node.partner, let partnerValue = value[partner.id] {
                        let endPoint: CGPoint =  proxy[partnerValue]
                        Line(startPoint: myPoint, endPoint: endPoint)
                            .stroke(lineWidth: 2)
                            .fill(.moduBlack)
                    }
                    let middleOfParents = node.partner == nil ? myPoint : self.middleOfPoints(myPoint, proxy[value[self.node.partner!.id] ?? myValue])
                    ForEach(node.children, id: \.self) { children in
                        let endPoint = value[children.id] == nil ? middleOfParents : proxy[value[children.id]!]
                        Line(startPoint: middleOfParents, endPoint: endPoint)
                            .stroke(lineWidth: 2)
                            .fill(.moduBlack)
                        
                    }
                }
            }
        }
        .customHalfSheet($isPresented) {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 44) {
                    Text("추가하고 싶은 관계를 선택하세요")
                        .font(.customFont(.headline))
                        .foregroundStyle(.moduBlack)
                    
                    VStack(spacing: 16) {
                        ForEach(CaseOfAdd.allCases, id: \.self) { addCase in
                            let isEnabled = addCase.canAddMember(node)
                            Button(action: {
                                self.selectedAddCase = addCase
                            }) {
                                VStack(spacing: 16) {
                                    HStack {
                                        Text(addCase.rawValue)
                                        Spacer()
                                        if selectedAddCase == addCase {
                                            Image(systemName: "checkmark")
                                        }
                                        if !isEnabled {
                                            Text("이미 추가 됨")
                                        }
                                    }
                                    .font(.customFont(.body))
                                    .foregroundStyle(isEnabled ? .moduBlack : .disableText)
                                    
                                    Divider()
                                        .foregroundStyle(.disableLine)
                                }
                            }
                            .disabled(!isEnabled)
                        }
                    }
                }
                
                Spacer()
                
                ModumoaRoundedRectangleButton("다음") {
                    self.isPresented = false
                    self.addNodeViewisPushed = true
                }
                .disabled(selectedAddCase == nil)
            }
            
        }
        .navigationDestination(isPresented: $addNodeViewisPushed) {
            MemberAddView(from: $node, with: $selectedAddCase, isPushed: $addNodeViewisPushed)
        }
        .navigationDestination(isPresented: $detailNodeViewisPushed, destination: {
            MemberDetailView(isPushed: $detailNodeViewisPushed, node: $node, fromMe: $fromMe)
        })
        .onAppear {
            /// 자식으로부터 나의 파트너를 추가할 경우, 나의 자식과 파트너의 자식을 같게해주게 되면 다음 Loading 에서 나의 자식이 없어지는 현상 발견
            if let partner = node.partner, node.children != partner.children {
                let children = node.children + partner.children
                node.children = children
                node.partner?.children = children
            }
        }
    }
    
    private func middleOfPoints(_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        let x = (lhs.x + rhs.x) / 2
        let y = (lhs.y + rhs.y) / 2
        return CGPoint(x: x, y: y)
    }
    
    @ViewBuilder
    private func cardViewWithButton(_ node: Node) -> some View {
        VStack {
            CardView(member: node.member)
                .onTapGesture {
                    fromMe = node == self.node
                    detailNodeViewisPushed = true
                }
            Button(action: {
                self.fromMe = self.node == node
                isPresented = true
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


