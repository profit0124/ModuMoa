//
//  MemberAboTypeView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/30/23.
//

import SwiftUI

struct MemberAboTypeView: View {
    
    var title: String = "혈액형을 선택해주세요"
    @Binding var aboType: BloodType.AboType?
    @Binding var isPresented: Bool
    let completion: () -> Void
    @Environment(\.isNoSafeAreaDevice) var isNoSafeArea
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.customFont(.title1).bold())
                .padding(.bottom, .betweenContents)
//
            ForEach(BloodType.AboType.allCases, id: \.self) { value in
                VStack(spacing: 0) {
                    HStack {
                        Text(value.rawValue)
                            .font(.customFont(.body))
                        Spacer()
                        if value == aboType {
                            Image(systemName: "checkmark")
                                .font(.customFont(.body))
                        }
                    }
                    .background {
                        Color.white
                    }
                    .onTapGesture {
                        aboType = value
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
            
            ModumoaRoundedRectangleButton("완료") {
                isPresented = false
                completion()
            }
            .disabled(aboType == nil)
        }
        .padding(.bottom, isNoSafeArea ? 16 : 0)
    }
}
#Preview {
    MemberAboTypeView(aboType: .constant(BloodType.AboType.AB), isPresented: .constant(false)) {
        
    }
}
