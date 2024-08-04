//
//  OptionView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/29/24.
//

import SwiftUI

struct OptionView: View {
    
    @Binding var nicknameMode: NicknameMode
    @Binding var baseNodeMode: SideOfBaseNode
    
    @State private var isNicknameButtonTapped: Bool = false
    @State private var isBaseNodeButtonTapped: Bool = false
    
    let action: (SideOfBaseNode) -> Void
    @State private var myNode: Node?
    
    var body: some View {
        HStack(alignment: .top, spacing: .betweenElements) {
            Spacer()
            VStack(spacing: 1) {
                Button(action:{
                    isBaseNodeButtonTapped = false
                    isNicknameButtonTapped.toggle()
                }) {
                    OptionButtonView(name: "arrow.left.arrow.right")
                }
                
                Button(action:{
                    isNicknameButtonTapped = false
                    isBaseNodeButtonTapped.toggle()
                }) {
                    OptionButtonView(name: "figure.stand.line.dotted.figure.stand")
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .topTrailing) {
            ZStack {
                if isNicknameButtonTapped {
                    NicknameOptionView()
                }
                
                if isBaseNodeButtonTapped {
                    BaseNodeOptionView()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.trailing, 48)
        }
        .task {
            guard let stringID = UserDefaults.standard.myNodeID else { return }
            let id = UUID(uuidString: stringID)!
            guard let myNode = await NodeDatabase.shared.fetchNode(id) else { return }
            self.myNode = myNode
        }
    }
    
    @ViewBuilder private func NicknameOptionView() -> some View {
        VStack(spacing: 1) {
            ForEach(NicknameMode.allCases, id: \.self) { name in
                Button(action: {
                    UserDefaults.standard.nicknameMode = name
                    nicknameMode = name
                    isNicknameButtonTapped = false
                }) {
                    HStack(spacing: .betweenTextAndLine) {
                        Text(name.rawValue)
                        Spacer()
                        Image(systemName: name.imageName)
                    }
                    .font(.customFont(.caption1))
                    .foregroundStyle(.moduBlack)
                    .padding(.betweenHeadlineAndTitle2)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 20)
                    .background {
                        Color.disableCapture
                    }
                }
                .overlay(alignment: .leading) {
                    if nicknameMode == name {
                        Image(systemName: "checkmark")
                            .font(.customFont(.caption1))
                            .foregroundStyle(.moduBlack)
                            .padding(.leading, 8)
                    }
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.leading, 100)
    }
    
    @ViewBuilder private func BaseNodeOptionView() -> some View {
        VStack(spacing: 1) {
            ForEach(SideOfBaseNode.allCases, id: \.self) { side in
                let isEnabled = side.possibleChangeMode(myNode)
                Button(action: {
                    action(side)
                    isBaseNodeButtonTapped = false
                }) {
                    HStack(spacing: .betweenTextAndLine) {
                        Text(side.rawValue)
                        Spacer()
                        Image(systemName: side.imageName)
                    }
                    .font(.customFont(.caption1))
                    .foregroundStyle(isEnabled ? .moduBlack : .disableText)
                    .padding(.betweenHeadlineAndTitle2)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 20)
                    .background {
                        Color.disableCapture
                    }
                    .overlay(alignment: .leading) {
                        if baseNodeMode == side {
                            Image(systemName: "checkmark")
                                .font(.customFont(.caption1))
                                .foregroundStyle(isEnabled ? .moduBlack : .disableText)
                                .padding(.leading, 8)
                        }
                    }
                }
                .disabled(!isEnabled)
                
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.leading, 100)
        .padding(.top, 37)
    }
}

#Preview {
    OptionView(nicknameMode: .constant(.nickname), baseNodeMode: .constant(.sideOfFather)) {
        print($0)
    }
}
