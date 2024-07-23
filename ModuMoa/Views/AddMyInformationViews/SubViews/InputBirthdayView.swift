//
//  InputBirthdayView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/28/23.
//

import SwiftUI

struct InputBirthdayView: View {
    @Binding var viewModel: AddMyInformationViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(systemName: "chevron.left")
                .resizable()
                .font(.customFont(.headline))
            
                .frame(width: 10, height: 20)
                .onTapGesture {
                    if viewModel.caseOfAddMyInfromationView == .birthday {
                        viewModel.previousButtonTapped()
                    }
                }
                .padding(.leading, 8)
            VStack(alignment: .leading, spacing: 0) {
                Text("생일을 선택해주세요")
                    .font(.customFont(.largeTitle).bold())
                    .padding(.top, .betweenElements)
                    .padding(.bottom, .betweenTitleAndContent)
                
                DatePicker("", selection: $viewModel.birthDay, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .environment(\.locale, Locale.init(identifier: "ko-kr"))
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, .betweenElements)
                
                Text(viewModel.birthDay.toString())
                    .font(.customFont(.callOut))
                    .foregroundStyle(.disableText)
                    .padding(.bottom, .betweenSelectPoint)
                
                ModumoaMemberSectionView(title: "성별", value: viewModel.sex?.rawValue ?? "모름")
                    .padding(.bottom, .betweenElements)
                
                ModumoaMemberSectionView(title: "이름", value: viewModel.name)
                
                Spacer()
                
                ModumoaRoundedRectangleButton("다음") {
                    if viewModel.caseOfAddMyInfromationView == .birthday {
                        viewModel.nextButtonTapped()
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

