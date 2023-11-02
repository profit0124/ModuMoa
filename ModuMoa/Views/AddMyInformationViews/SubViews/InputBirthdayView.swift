//
//  InputBirthdayView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/28/23.
//

import SwiftUI

struct InputBirthdayView: View {
    
    @Binding var index: Int
    @Binding var birthday: Date
    
    @Binding var sex: Sex?
    @Binding var name: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Image(systemName: "chevron.left")
                .resizable()
                .font(.customFont(.headline))
            
                .frame(width: 10, height: 20)
                .onTapGesture {
                    index -= 1
                }
                .padding(.leading, 8)
            VStack(alignment: .leading, spacing: 0) {
                Text("생일을 선택해주세요")
                    .font(.customFont(.largeTitle).bold())
                    .padding(.top, .betweenElements)
                    .padding(.bottom, .betweenTitleAndContent)
                
                DatePicker("", selection: $birthday, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .environment(\.locale, Locale.init(identifier: "ko-kr"))
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, .betweenElements)
                
                Text(birthday.toString())
                    .font(.customFont(.callOut))
                    .foregroundStyle(.disableText)
                    .padding(.bottom, .betweenSelectPoint)
                
                makeSection("성별", sex?.rawValue ?? "")
                    .padding(.bottom, .betweenElements)
                
                makeSection("이름", name)
                
                Spacer()
            
                RoundedRectangleButtonView(title: "다음")
                    .onTapGesture {
                        index += 1
                    }
            }
            .padding(.horizontal, 20)
        }
    }
    
    @ViewBuilder
    private func makeSection(_ headline: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: .betweenHeadlineAndTitle2) {
            Text(headline)
                .foregroundStyle(.moduBlack)
                .font(.customFont(.footnote))
                
            Text(value)
                .foregroundStyle(.moduBlack)
                .font(.customFont(.body))
        }
        .padding(.bottom, .betweenContents)
    }
}

//#Preview {
//    InputBirthdayView(index: .constant(2), birthday: .constant(Date()))
//        
//}
