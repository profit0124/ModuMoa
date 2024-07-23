//
//  SelectGenderView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/28/23.
//

import SwiftUI

struct SelectGenderView: View {
    
    @Binding var viewModel: AddMyInformationViewModel
    
    var body: some View {
        GeometryReader { reader in
            let width = reader.size.width
            VStack(alignment: .leading, spacing: 0) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .font(.customFont(.headline))
                    
                    .frame(width: 10, height: 20)
                    .onTapGesture {
                        if viewModel.caseOfAddMyInfromationView == .sex {
                            viewModel.previousButtonTapped()
                        }
                    }
                    .padding(.leading, 8)
                    
                VStack(alignment: .leading) {
                    HStack {
                        Text("성별을 선택해주세요")
                            .font(.customFont(.largeTitle).bold())
                            .padding(.top, .betweenElements)
                            .padding(.bottom, .betweenTitleAndContent)
                        Spacer()
                    }
                    HStack(spacing: 8) {
                        ForEach(Sex.allCases, id: \.self) { value in
                            selectedCapule(value, width: width)
                        }
                    }
                    .padding(.bottom, .betweenSelectPoint)
                    
                    makeSection("이름", viewModel.name)
                    
                    Spacer()
                    
                    if viewModel.sex != nil {
                        RoundedRectangleButtonView(title: "다음", isEnabled: true)
                            .onTapGesture {
                                if viewModel.caseOfAddMyInfromationView == .sex {
                                    viewModel.nextButtonTapped()
                                }
                            }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func selectedCapule(_ value: Sex, width: CGFloat) -> some View {
        let width = (width - 44) / 4
        Text(value.rawValue)
            .font(.customFont(.callOut))
            .foregroundStyle(viewModel.sex == value ? .moduYellow : .disableText)
            .padding(.vertical, 8)
            .frame(width: width)
            .background {
                Capsule()
                    .fill(viewModel.sex == value ? .moduBlack : .disableCapture)
            }
            .onTapGesture {
                viewModel.sex = value
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
