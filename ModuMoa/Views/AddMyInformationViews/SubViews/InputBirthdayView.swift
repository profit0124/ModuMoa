//
//  InputBirthdayView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/28/23.
//

import SwiftUI
import ComposableArchitecture

struct InputBirthdayView: View {
    
//    @Binding var index: Int
//    @Binding var birthday: Date
//    
//    @Binding var sex: Sex?
//    @Binding var name: String
    
    let store: StoreOf<InputBirthDay>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .font(.customFont(.headline))
                
                    .frame(width: 10, height: 20)
                    .onTapGesture {
                        viewStore.send(.previousIndex)
                    }
                    .padding(.leading, 8)
                VStack(alignment: .leading, spacing: 0) {
                    Text("생일을 선택해주세요")
                        .font(.customFont(.largeTitle).bold())
                        .padding(.top, .betweenElements)
                        .padding(.bottom, .betweenTitleAndContent)
                    
                    DatePicker("", selection: viewStore.$date, displayedComponents: .date)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .environment(\.locale, Locale.init(identifier: "ko-kr"))
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, .betweenElements)
                    
                    Text(viewStore.date.toString())
                        .font(.customFont(.callOut))
                        .foregroundStyle(.disableText)
                        .padding(.bottom, .betweenSelectPoint)
                    
                    makeSection("성별", viewStore.sex.rawValue)
                        .padding(.bottom, .betweenElements)
                    
                    makeSection("이름", viewStore.name)
                    
                    Spacer()
                
                    RoundedRectangleButtonView(title: "다음")
                        .onTapGesture {
                            viewStore.send(.nextIndex)
                        }
                }
                .padding(.horizontal, 20)
            }
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
