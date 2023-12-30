//
//  MemberBloodTypeView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/30/23.
//

import SwiftUI

struct MemberRhTypeView: View {
    
    var title: String = "Rh식 혈액형을 선택해주세요"
    @Binding var rhType: BloodType.RhType?
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.customFont(.title1).bold())
                .padding(.bottom, .betweenContents)
//            
            ForEach(BloodType.RhType.allCases, id: \.self) { value in
                VStack(spacing: 0) {
                    HStack {
                        Text(value.rawValue)
                            .font(.customFont(.body))
                        Spacer()
                        if value == rhType {
                            Image(systemName: "checkmark")
                                .font(.customFont(.body))
                        }
                    }
                    .background {
                        Color.white
                    }
                    .onTapGesture {
                        rhType = value
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
            if rhType == nil {
                RoundedRectangleButtonView(title: "완료", isEnabled: false)
            } else {
                RoundedRectangleButtonView(title: "완료", isEnabled: true)
                    .onTapGesture {
                        isPresented = false
                    }
            }
        }
    }
}


#Preview {
    MemberRhTypeView(rhType: .constant(.positive), isPresented: .constant(true))
}
