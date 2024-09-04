//
//  CardWithButtonView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 9/4/24.
//

import SwiftUI

struct CardWithButtonView: View {
    
    @Environment(ModumoaRouter.self) var coordinator
    @Environment(\.isNoSafeAreaDevice) var isNoSafeArea
    
    let node: Node
    
    @State private var selectedAddCase: CaseOfAdd?
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            CardView(member: node.member)
                .onTapGesture {
                    coordinator.push(.selectNode(node))
                }
            Button(action: {
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
        .customDynamicHeightSheet($isPresented) {
            halfSheetView()
        }
    }
    
    @ViewBuilder
    private func halfSheetView() -> some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 44) {
                Text("추가하고 싶은 관계를 선택하세요")
                    .font(.customFont(.headline))
                    .foregroundStyle(.moduBlack)
                
                VStack(spacing: 16) {
                    ForEach(CaseOfAdd.allCases, id: \.self) { addCase in
                        let possible = node.member.nickNames.checkPossible(addCase)
                        let isEnabled = addCase.canAddMember(node) && possible
                        Button(action: {
                            selectedAddCase = addCase
                        }) {
                            VStack(spacing: 16) {
                                HStack {
                                    let text = node.member.nickNames.nickname
                                    Text("\(text)의 \(addCase.rawValue)")
                                    Spacer()
                                    if selectedAddCase == addCase {
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
                isPresented = false
                coordinator.push(.addNode(node: node, caseOfAdd: selectedAddCase))
                selectedAddCase = nil
            }
            .disabled(selectedAddCase == nil)
        }
        .padding(.bottom, isNoSafeArea ? 16 : 0)
    }
}

#Preview {
    CardWithButtonView(node: .init(member: .init(name: "", bloodType: .init(abo: .A, rh: .negative), sex: .male)))
}
