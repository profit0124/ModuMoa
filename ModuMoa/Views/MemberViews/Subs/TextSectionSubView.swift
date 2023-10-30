//
//  TextSectionSubView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/29/23.
//

import SwiftUI


struct TextSectionSubView: View {
    
    var needSpacing: Bool
    @Binding var value: String
    let sectionType: SectionType
    let bloodType: SectionType.MemberBloodType?
    @Binding var selectedSection: SectionType?
    @Binding var selectedBloodType: SectionType.MemberBloodType?
    @Binding var memberViewType: MemberViewType
    
    var body: some View {
 
        VStack {
            HStack {
                Text(!value.isEmpty ? value :
                        sectionType != .bloodType ? sectionType.rawValue : bloodType?.rawValue ?? "")
                    .font(.customFont(.title2))
                    .foregroundStyle(!value.isEmpty ? .moduBlack : .disableText)
                if needSpacing {
                    Spacer()
                }
                if memberViewType != .detail {
                    Image(systemName: "chevron.right")
                        .font(.customFont(.body))
                        .foregroundStyle(.disableText)
                }
            }
            .padding(.bottom, 8)
            .background {
                VStack {
                    Color.white
                    Rectangle()
                        .fill(sectionType != .bloodType ?
                              selectedSection == sectionType ? .moduBlack : .disableLine :
                                selectedBloodType == bloodType ? .moduBlack : .disableLine)
                        .frame(height: 2)
                    
                }
            }
        }
    }
}

#Preview {
    TextSectionSubView(needSpacing: true, value: .constant(""), sectionType: .sex, bloodType: nil, selectedSection: .constant(nil), selectedBloodType: .constant(nil), memberViewType: .constant(.add))
}
