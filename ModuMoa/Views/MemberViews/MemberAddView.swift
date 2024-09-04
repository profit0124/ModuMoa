//
//  MemberAddView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/20/24.
//

import SwiftUI

struct MemberAddView: View {
    
    @State private var vm: MemberAddViewModel
    @Environment(\.isNoSafeAreaDevice) var isNoSafeArea
    @Environment(ModumoaRouter.self) var coordinator
    
    init(from node: Node, with selectedAddCase: CaseOfAdd?) {
        self._vm = .init(initialValue: .init(fromNode: node, selectedAddCase: selectedAddCase))
    }
    
    var body: some View {
        VStack(spacing: .betweenElements) {
            HStack {
                Button(action: {
                    coordinator.pop()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("뒤로가기")
                    }
                    .font(.customFont(.callOut))
                    .foregroundStyle(.moduBlack)
                }
                Spacer()
            }
            
            MemberFormView(name: $vm.name, sex: $vm.sex, birthDay: $vm.birthDay, bloodType: $vm.bloodType, rh: $vm.rh, abo: $vm.abo)
            
            Spacer()
            
            ModumoaRoundedRectangleButton("완료") {
                saveNode()
            }
            .disabled(vm.name.isEmpty || vm.sex == nil)
        }
        .padding(.horizontal, .betweenTextAndLine)
        .padding(.bottom, isNoSafeArea ? 16 : 0)
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
    }
    
    func saveNode() {
        Task {
            do {
                try await vm.saveButtonTapped()
                coordinator.pop()
            } catch {
                fatalError("error: \(error)")
            }
        }
        
    }
}
