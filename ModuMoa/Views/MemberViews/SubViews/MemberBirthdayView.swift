//
//  MemberBirthdayView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/30/23.
//

import SwiftUI

struct MemberBirthdayView: View {
    
    var title: String = "생일을 설정해주세요"
    @State private var tempBirthDay: Date
    @Binding var birthday: Date?
    @Binding var isPresented: Bool
    let completion: () -> Void
    @Environment(\.isNoSafeAreaDevice) var isNoSafeArea
    
    init(birthday: Binding<Date?>, isPresented: Binding<Bool>, completion: @escaping () -> Void) {
        self.tempBirthDay = birthday.wrappedValue ?? Date()
        self._birthday = birthday
        self._isPresented = isPresented
        self.completion = completion
    }
    
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
                .environment(\.locale, Locale.init(identifier: "ko-kr"))
                
                Spacer()
            }
            
            Spacer()
            
            ModumoaRoundedRectangleButton("완료") {
                birthday = tempBirthDay
                isPresented = false
                completion()
            }
        }
        .padding(.bottom, isNoSafeArea ? 16 : 0)
    }
}
