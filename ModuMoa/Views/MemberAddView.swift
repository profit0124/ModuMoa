//
//  MemberAddView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/20/24.
//

import SwiftUI

struct MemberAddView: View {
    
//    let from: Node
    let from: Node
    let addCase: KindOfAdd
    
    @State private var name: String = .init()
    @State private var sex: Sex?
    @State private var birthDay: Date?
    @State private var bloodType: BloodType = .init(abo: .none, rh: .none)
    @State private var rh: BloodType.RhType?
    @State private var abo: BloodType.AboType?
    
    var body: some View {
        VStack(spacing: .betweenElements) {
            HStack {
                Button(action: {}) {
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
                .overlay(alignment: .bottom) {
                    
                }
            
            Spacer()
            
            Button(action:{}) {
                RoundedRectangleButtonView(title: "완료")
            }
            .disabled(name.isEmpty || sex == nil)
            
        }
        .padding(.horizontal, .betweenTextAndLine)
        .ignoresSafeArea(.keyboard)
        
    }
}

#Preview {
    MemberAddView(from: .init(member: .init(name: "adsf", bloodType: .init(abo: .A, rh: .negative), sex: .female)), addCase: .leftParent)
}
