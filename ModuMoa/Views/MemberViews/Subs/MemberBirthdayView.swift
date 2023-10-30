//
//  MemberBirthdayView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/30/23.
//

import SwiftUI

struct MemberBirthdayView: View {
    
    var title: String = ""
    @Binding var birthday: Date
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.customFont(.title1).bold())
                .padding(.bottom, .betweenContents)
            
            HStack {
                Spacer()
                DatePicker(selection: $birthday, displayedComponents: .date, label: {
                    
                })
                .datePickerStyle(.wheel)
                .labelsHidden()
                Spacer()
            }
            
            
//            ForEach(Sex.allCases, id: \.self) { value in
//                VStack(spacing: 0) {
//                    HStack {
//                        Text(value.rawValue)
//                            .font(.customFont(.body))
//                        Spacer()
//                        if value == sex {
//                            Image(systemName: "checkmark")
//                                .font(.customFont(.body))
//                        }
//                    }
//                    .background {
//                        Color.white
//                    }
//                    .onTapGesture {
//                        sex = value
//                    }
//                    .padding(.bottom, .betweenTextAndLine)
//                    if value == .male {
//                        Rectangle()
//                            .frame(height: 2)
//                            .padding(.bottom, .betweenTextAndLine)
//                        
//                    }
//                }
//                
//            }
            
            Spacer()

            RoundedRectangleButtonView(title: "완료", isEnabled: true)
                .onTapGesture {
                    isPresented = false
                }
            
            
        }
    }
}

#Preview {
    MemberBirthdayView(title: "생일을 설정해주세요", birthday: .constant(Date()), isPresented: .constant(true))
}
