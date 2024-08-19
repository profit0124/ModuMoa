//
//  MemberUpdateView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/18/24.
//

import SwiftUI

struct MemberUpdateView: View {
    
    @Environment(\.nicknameMode) var nicknameMode
    
    @Binding var isPresented: Bool
    @State private var vm: MemberUpdateViewModel
    
    init(node: Node, isPresented: Binding<Bool>) {
        self._vm = .init(initialValue: .init(node: node))
        self._isPresented = isPresented
    }
    
    var body: some View {
        let member = vm.node.member
        VStack(spacing: .betweenElements) {
            // MARK: Navigation Bar
            HStack {
                Button(action: {
                    isPresented = false
                }) {
                    Text("닫기")
                }
                .font(.customFont(.callOut))
                .foregroundColor(.moduBlack)
                Spacer()
                
                Button(action: {
                    update()
                }) {
                    Text("저장")
                }
                .font(.customFont(.callOut))
                .foregroundColor(vm.isEnabled ? .moduBlack : .disableText)
                .disabled(!vm.isEnabled)
            }
            
            let nickname = member.getNickname(nicknameMode)
            MemberFormView(name: $vm.name, sex: $vm.sex, birthDay: $vm.birthDay, bloodType: $vm.bloodType, rh: $vm.rh, abo: $vm.abo, nickName: nickname)
        }
        .padding(.horizontal, 16)
    }
    
    func update() {
        Task {
            do {
                try await vm.saveButtonTapped()
                isPresented = false
            } catch {
                fatalError("error: \(error)")
            }
        }
    }
}
