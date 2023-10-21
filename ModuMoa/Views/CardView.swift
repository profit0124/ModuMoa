//
//  CardView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/21/23.
//

import SwiftUI

struct CardView: View {
    
    @State var name: String = "이미옥"
    @State var title: String = "어머니"
    @State var birthDay: String = "1964.05.27"
    @State var koreanAge: Int = 58
    @State var internationalAge: Int = 57
    @State var rhType: BloodType.RhType  = .positive
    @State var aboType: BloodType.AboType = .O
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(name)
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
                Text(title)
                    .foregroundStyle(.moduYellow)
                    .padding(.betweenHeadlineAndTitle2)
                    .background {
                        Capsule()
                            .fill(.moduBlack)
                    }
            }
            .padding(.bottom, .betweenHeadlineAndTitle2)
            
            HStack {
                Text(birthDay)
                    .font(.footnote)
                Text("\(koreanAge) 세(만 \(internationalAge)세)")
                    .font(.footnote)
            }
            
            Text("\(rhType.rawValue) \(aboType.rawValue)")
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
    CardView()
}
