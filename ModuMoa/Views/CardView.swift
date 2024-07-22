//
//  CardView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/21/23.
//

import SwiftUI
import Combine
import ComposableArchitecture

struct CardView: View {
    
    let member: Member
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(member.name)
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
                Text(member.nickName)
                    .foregroundStyle(.moduYellow)
                    .padding(.betweenHeadlineAndTitle2)
                    .background {
                        Capsule()
                            .fill(.moduBlack)
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
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 4)
                    .foregroundStyle(.moduBlack)
            }
        }
        
        
    }
}

#Preview {
    CardView(member: Member(name: "Kim", bloodType: .init(abo: .A, rh: .negative), sex: .female, birthday: Date()))
}
