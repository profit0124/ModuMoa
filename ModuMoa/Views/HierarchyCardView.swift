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
    
    init(node: Node) {
        self._vm = .init(initialValue: .init(node: node))
    }
    
    typealias Key = PreferKey<Member.ID, Anchor<CGPoint>>

    var body: some View {
        VStack(spacing: 80) {
            HStack(spacing: 20) {
                cardViewWithButton(vm.node)
                    .frame(width: 250)
                    .anchorPreference(key: Key.self, value: .center, transform: { anchor in
                        return [vm.node.id:anchor]
                    })
                
                if let partner = vm.node.partner {
                    cardViewWithButton(partner)
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
        .customDynamicHeightSheet($vm.isPresented) {
            halfSheetView()
        }
//        .customHalfSheet($vm.isPresented) {
//            halfSheetView()
//        }
        .navigationDestination(isPresented: $vm.addNodeViewisPushed) {
            if let unwrappedNode = Binding($vm.selectedNode) {
                MemberAddView(from: unwrappedNode, with: $vm.selectedAddCase, isPushed: $vm.addNodeViewisPushed)
            } else {
                
            }
        }
        .navigationDestination(isPresented: $vm.detailNodeViewIsPushed, destination: {
            if let node = vm.selectedNode {
                MemberDetailView(isPushed: $vm.detailNodeViewIsPushed, node: node)
                    .onDisappear {
                        vm.selectedNode = nil
                    }
            }
        })
    }
    
    private func middleOfPoints(_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        let x = (lhs.x + rhs.x) / 2
        let y = (lhs.y + rhs.y) / 2
        return CGPoint(x: x, y: y)
    }
    
    @ViewBuilder
    private func halfSheetView() -> some View {
        if let fromNode = vm.selectedNode {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 44) {
                    Text("추가하고 싶은 관계를 선택하세요")
                        .font(.customFont(.headline))
                        .foregroundStyle(.moduBlack)
                    
                    VStack(spacing: 16) {
                        ForEach(CaseOfAdd.allCases, id: \.self) { addCase in
//                            let fromNode = vm.fromMe ? vm.node : vm.node.partner!
                            let possible = fromNode.member.nickNames.checkPossible(addCase)
                            let isEnabled = addCase.canAddMember(fromNode) && possible
                            Button(action: {
                                self.vm.setSelectedAddCase(addCase)
                            }) {
                                VStack(spacing: 16) {
                                    HStack {
                                        let text = fromNode.member.nickNames.nickname
                                        Text("\(text)의 \(addCase.rawValue)")
                                        Spacer()
                                        if vm.selectedAddCase == addCase {
                                            Image(systemName: "checkmark")
                                        }
                                        if !isEnabled {
                                            let reason = possible ? "이미 추가 됨" : "기능 추가 예정"
                                            Text(reason)
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
                    self.vm.isPresented = false
                    self.vm.addNodeViewisPushed = true
                }
                .disabled(vm.selectedAddCase == nil)
            }
            .padding(.bottom, isNoSafeArea ? 16 : 0)
        }
        
    }
    
    @ViewBuilder
    private func cardViewWithButton(_ node: Node) -> some View {
        VStack {
            CardView(member: node.member)
                .onTapGesture {
                    vm.detailButtonTapped(node)
                }
            Button(action: {
                vm.plusButtonTapped(node)
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


