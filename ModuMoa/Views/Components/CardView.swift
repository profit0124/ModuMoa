//
//  CardView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/21/23.
//

import SwiftUI

struct CardView: View {
    
    @Environment(\.nicknameMode) var nicknameMode
    
    let member: Member
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(member.name)
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
                let nickname = nicknameMode == .title ? member.nickNames.title : member.nickNames.nickname
                Text(nickname)
                    .foregroundStyle(.moduYellow)
                    .padding(.betweenHeadlineAndTitle2)
                    .background{
                        if nickname.count == 1 {
                            Circle().fill(.moduBlack)
                        } else {
                            Capsule().fill(.moduBlack)
                        }
                    }
            }
            .padding(.bottom, .betweenHeadlineAndTitle2)
            
            HStack {
                Text(member.birthday?.toString() ?? "모름")
                    .font(.footnote)
                Text("\(member.age())")
                    .font(.footnote)
            }
            
            Text("\(member.bloodType.rh.rawValue) \(member.bloodType.abo.rawValue)")
                .font(.footnote)
        }
        .padding(.betweenElements)
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.white)
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(lineWidth: 4)
                    .foregroundStyle(.moduBlack)
            }
        }
    }
}

#Preview {
    CardView(member: Member(name: "Kim", bloodType: .init(abo: .A, rh: .negative), sex: .female, birthday: Date()))
}
