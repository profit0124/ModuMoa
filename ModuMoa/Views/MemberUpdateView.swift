//
//  MemberUpdateView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/18/24.
//

import SwiftUI
import ComposableArchitecture

struct MemberUpdateView: View {
    
    let store: StoreOf<MemberUpdate>
    
    @State private var member: Member
    
    @State private var name: String
    @State private var sex: Sex?
    @State private var birthDay: Date?
    @State private var bloodType: BloodType
    @State private var rh: BloodType.RhType?
    @State private var abo: BloodType.AboType?
    
    init(_ member: Member, with store: StoreOf<MemberUpdate>) {
        self.member = member
        self.name = member.name
        self.sex = member.sex
        self.birthDay = member.birthday
        self.bloodType = member.bloodType
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 22) {
                // MARK: Navigation Bar
                HStack {
                    Button(action: {
                        viewStore.send(.closeButtonTapped)
                    }) {
                        Text("닫기")
                    }
                    .font(.customFont(.callOut))
                    .foregroundColor(.moduBlack)
                    Spacer()
                    
                    Button(action: {
                        member.name = name
                        member.sex = sex ?? .none
                        member.bloodType = bloodType
                        member.birthday = birthDay
                        viewStore.send(.saveButtonTapped(member))
                    }) {
                        Text("저장")
                    }
                    .font(.customFont(.callOut))
                    .foregroundColor(isEnabled() ? .moduBlack : .disableText)
                    .disabled(!isEnabled())
                }
                
                MemberFormView(name: $name, sex: $sex, birthDay: $birthDay, bloodType: $bloodType, rh: $rh, abo: $abo)
            }
            .padding(.horizontal, 16)
            .onAppear {
                self.rh = bloodType.rh
                self.abo = bloodType.abo
            }
        }
        
    }
    
    private func isEnabled() -> Bool {
        if name.isEmpty || sex == nil || rh == nil || abo == nil {
            return false
        }
        if member.name != name {
            return true
        }
        if member.sex != sex {
            return true
        }
        if member.birthday != birthDay {
            return true
        }
        if member.bloodType != bloodType {
            return true
        }
        return false
    }
}

//#Preview {
//    MemberUpdateView(member)
//}
