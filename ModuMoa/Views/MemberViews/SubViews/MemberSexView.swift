//
//  MemberSexView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/30/23.
//

import SwiftUI

struct MemberSexView: View {
    var title: String = "성별을 선택해주세요"
    @Binding var sex: Sex?
    @Binding var isPresented: Bool
    let completion: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.customFont(.title1).bold())
                .padding(.bottom, .betweenContents)
            
            ForEach(Sex.allCases, id: \.self) { value in
                VStack(spacing: 0) {
                    HStack {
                        Text(value.rawValue)
                            .font(.customFont(.body))
                        Spacer()
                        if value == sex {
                            Image(systemName: "checkmark")
                                .font(.customFont(.body))
                        }
                    }
                    .background {
                        Color.white
                    }
                    .onTapGesture {
                        sex = value
                    }
                    .padding(.bottom, .betweenTextAndLine)
                    if value != .none {
                        Rectangle()
                            .fill(.disableLine)
                            .frame(height: 2)
                            .padding(.bottom, .betweenTextAndLine)
                    }
                }
            }
            
            Spacer()
            
            if sex == nil {
                RoundedRectangleButtonView(title: "완료", isEnabled: false)
            } else {
                RoundedRectangleButtonView(title: "완료", isEnabled: true)
                    .onTapGesture {
                        if sex != nil {
                            isPresented = false
                            completion()
                        }
                    }
            }        }
    }
}

#Preview {
    MemberSexView(sex: .constant(.male), isPresented: .constant(true)) {
        
    }
}
