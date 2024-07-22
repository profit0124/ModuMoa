//
//  MemberAddView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/20/24.
//

import SwiftUI
import ComposableArchitecture

struct MemberAddView: View {

    @State private var name: String = .init()
    @State private var sex: Sex?
    @State private var birthDay: Date?
    @State private var bloodType: BloodType = .init(abo: .none, rh: .none)
    @State private var rh: BloodType.RhType?
    @State private var abo: BloodType.AboType?
    @Binding var isPushed: Bool
    
    let addAction: (Node) -> Void
    
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
            
            MemberFormView(name: $name, sex: $sex, birthDay: $birthDay, bloodType: $bloodType, rh: $rh, abo: $abo)
            
            Spacer()
            
            Button(action:{
                if let sex {
                    let node = Node(member: .init(name: name, bloodType: bloodType, sex: sex, birthday: birthDay))
                    isPushed = false
                    addAction(node)
                }
            }) {
                RoundedRectangleButtonView(title: "완료")
            }
            .disabled(name.isEmpty || sex == nil)
            
        }
        .padding(.horizontal, .betweenTextAndLine)
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
    }
}
//
//#Preview {
//    MemberAddView(store: .init(initialState: MemberAdd.State(addCase: .daughter), reducer: { MemberAdd() }))
//}
