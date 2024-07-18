//
//  MemberBirthdayView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/30/23.
//

import SwiftUI

struct MemberBirthdayView: View {
    
    var title: String = "생일을 설정해주세요"
    @State private var tempBirthDay: Date = Date()
    @Binding var birthday: Date?
    @Binding var isPresented: Bool
    let completion: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.customFont(.title1).bold())
                .padding(.bottom, .betweenContents)
            
            HStack {
                Spacer()
                DatePicker(selection: $tempBirthDay, displayedComponents: .date, label: {
                    
                })
                .datePickerStyle(.wheel)
                .labelsHidden()
                Spacer()
            }
            
            Spacer()

            RoundedRectangleButtonView(title: "완료", isEnabled: true)
                .onTapGesture {
                    birthday = tempBirthDay
                    isPresented = false
                    completion()
                }
        }
    }
}

#Preview {
    MemberBirthdayView(title: "생일을 설정해주세요", birthday: .constant(Date()), isPresented: .constant(true)) {
        
    }
}
