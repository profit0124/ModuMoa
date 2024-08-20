//
//  SelectGenderView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/28/23.
//

import SwiftUI

struct SelectGenderView: View {
    
    @Binding var viewModel: AddMyInformationViewModel
    @Environment(\.isNoSafeAreaDevice) var isNoSafeArea
    
    var body: some View {
        GeometryReader { reader in
            let width = reader.size.width
            VStack(alignment: .leading, spacing: .betweenElements) {
                // MARK: 네비게이션 BackButton
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
                
                // MARK: Contents
                VStack(alignment: .leading, spacing: .betweenSelectPoint) {
                    VStack(alignment: .leading, spacing: .betweenTitleAndContent) {
                        HStack {
                            Text("성별을 선택해주세요")
                                .font(.customFont(.largeTitle).bold())
                            Spacer()
                        }
                        HStack(spacing: 8) {
                            ForEach(Sex.allCases, id: \.self) { value in
                                selectedCapule(value, width: width)
                            }
                        }
                    }
                    
                    ModumoaMemberSectionView(title: "이름", value: viewModel.name)
                    
                    Spacer()
                    
                    if viewModel.sex != nil {
                        ModumoaRoundedRectangleButton("다음") {
                            if viewModel.caseOfAddMyInfromationView == .sex {
                                viewModel.nextButtonTapped()
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .padding(.bottom, isNoSafeArea ? 16 : 0)
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
}
