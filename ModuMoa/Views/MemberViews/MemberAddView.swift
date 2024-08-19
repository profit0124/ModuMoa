//
//  MemberAddView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/20/24.
//

import SwiftUI

struct MemberAddView: View {
    
    @State private var vm: MemberAddViewModel
    @Binding var isPushed: Bool
    
    init(from node: Binding<Node>, with selectedAddCase: Binding<CaseOfAdd?>, isPushed: Binding<Bool>) {
        self._vm = .init(initialValue: .init(fromNode: node.wrappedValue, selectedAddCase: selectedAddCase.wrappedValue))
        self._isPushed = isPushed
    }
    
    var body: some View {
        
        VStack(spacing: .betweenElements) {
            HStack {
                Button(action: {
                    isPushed = false
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
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
    }
    
    func saveNode() {
        Task {
            do {
                try await vm.saveButtonTapped()
                isPushed = false
            } catch {
                fatalError("error: \(error)")
            }
        }
        
    }
}
