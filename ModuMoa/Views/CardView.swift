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
    
    @State var member: Member
    @State var title: String = "어머니"
    @State var birthDay: String = "1964.05.27"
    @State var koreanAge: Int = 58
    @State var internationalAge: Int = 57
    
    let store: StoreOf<Card>
    
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(viewStore.member.name)
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
                    Text(viewStore.member.birthday?.toString() ?? Date().toString())
                        .font(.footnote)
                    Text("\(viewStore.member.age())")
                        .font(.footnote)
                }
                
                Text("\(viewStore.member.bloodType.rh.rawValue) \(viewStore.member.bloodType.abo.rawValue)")
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
}

#Preview {
    CardView(member: Member(name: "Kim", bloodType: .init(abo: .A, rh: .negative), sex: .female, birthday: Date()),
             store: StoreOf<Card>(initialState: Card.State(member: Member(name: "Kim", bloodType: .init(abo: .A, rh: .negative), sex: .female, birthday: Date()))) { Card() })
}
