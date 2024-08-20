//
//  InputBirthdayView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/28/23.
//

import SwiftUI

struct InputBirthdayView: View {
    @Binding var viewModel: AddMyInformationViewModel
    @Environment(\.isNoSafeAreaDevice) var isNoSafeArea
    @Environment(\.isSmallScreenDevice) var isSmallScreenDevice
    
    var body: some View {
        VStack(alignment: .leading, spacing: isSmallScreenDevice ? .betweenElements / 2 : .betweenElements) {
            // MARK: Navigation Backbutton
            Image(systemName: "chevron.left")
                .resizable()
                .font(.customFont(.headline))
                .frame(width: 10, height: 20)
                .padding(.leading, 8)
                .onTapGesture {
                    if viewModel.caseOfAddMyInfromationView == .birthday {
                        viewModel.previousButtonTapped()
                    }
                }
            // MARK: Content
            VStack(alignment:.leading, spacing: isSmallScreenDevice ? .betweenSelectPoint / 2 : .betweenSelectPoint) {
                VStack(alignment: .leading, spacing: isSmallScreenDevice ? .betweenElements / 2 : .betweenElements) {
                    VStack(alignment: .leading, spacing: isSmallScreenDevice ? .betweenTitleAndContent / 2 : .betweenTitleAndContent) {
                        Text("생일을 선택해주세요")
                            .font(.customFont(.largeTitle).bold())
                        
                        DatePicker("", selection: $viewModel.birthDay, displayedComponents: .date)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .environment(\.locale, Locale.init(identifier: "ko-kr"))
                    }
                    Text(viewModel.birthDay.toString())
                        .font(.customFont(.callOut))
                        .foregroundStyle(.disableText)
                }
                
                VStack(alignment: .leading, spacing: .betweenElements) {
                    ModumoaMemberSectionView(title: "성별", value: viewModel.sex?.rawValue ?? "모름")
                    
                    ModumoaMemberSectionView(title: "이름", value: viewModel.name)
                }
                
                Spacer()
                
                ModumoaRoundedRectangleButton("다음") {
                    if viewModel.caseOfAddMyInfromationView == .birthday {
                        viewModel.nextButtonTapped()
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.bottom, isNoSafeArea ? 16 : 0)
    }
}

