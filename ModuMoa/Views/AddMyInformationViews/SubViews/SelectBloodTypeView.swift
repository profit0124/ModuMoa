//
//  SelectBloodTypeView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/29/23.
//

import SwiftUI

struct SelectBloodTypeView: View {
    @Binding var viewModel: AddMyInformationViewModel
    @State private var isPresented: Bool = false
    @Environment(RootViewModel.self) var rootViewModel
    
    var body: some View {
        GeometryReader { reader in
            let width = reader.size.width
            VStack(alignment: .leading, spacing: 0) {
                
                Image(systemName: "chevron.left")
                    .resizable()
                    .font(.customFont(.headline))
                
                    .frame(width: 10, height: 20)
                    .onTapGesture {
                        if viewModel.caseOfAddMyInfromationView == .bloodType {
                            viewModel.previousButtonTapped()
                        }
                    }
                    .padding(.leading, 8)
                VStack(alignment: .leading, spacing: 0) {
                    Text("혈액형을 입력해주세요")
                        .font(.customFont(.largeTitle).bold())
                        .padding(.top, .betweenElements)
                        .padding(.bottom, .betweenTitleAndContent)
                    
                    HStack {
                        Group {
                            if let rhType = viewModel.rhType {
                                Text(rhType == .none ? "Rh식 모름" : rhType.rawValue)
                                    .font(.customFont(.body))
                            } else {
                                Text("Rh식")
                                    .font(.customFont(.body))
                            }
                            Image(systemName: "chevron.right")
                        }
                        .foregroundStyle(viewModel.rhType == nil ? .disableText : .moduBlack)
                        .onTapGesture {
                            if !isPresented {
                                isPresented = true
                            }
                        }
                        Spacer()
                    }
                    .padding(.bottom, .betweenElements)
                    
                    HStack(spacing: 8) {
                        ForEach(BloodType.AboType.allCases, id: \.self) { type in
                            if type != .none {
                                selectedCapusle(type, width: width)
                            }
                        }
                    }
                    .padding(.bottom, .betweenSelectPoint)
                    
                    makeSection("생일", viewModel.birthDay.toString())
                        .padding(.bottom, .betweenElements)
                    
                    
                    makeSection("성별", viewModel.sex?.rawValue ?? "모름")
                        .padding(.bottom, .betweenElements)
                    
                    makeSection("이름", viewModel.name)
                    
                    Spacer()
                
                    if viewModel.aboType != nil, viewModel.rhType != nil {
                        ModumoaRoundedRectangleButton("완료") {
                            if let node = viewModel.saveMyInformation() {
                                rootViewModel.setBaseNode(node)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .sheet(isPresented: $isPresented) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Rh 식 혈액형을 입력하세요")
                        .font(.customFont(.title2))
                        .padding(.top, .betweenContents)
                        .padding(.bottom, .betweenTitleAndContent)
                    Spacer()
                }
                
                
                ForEach(BloodType.RhType.allCases, id: \.self) { type in
                    Group {
                        HStack {
                            Text(type.rawValue)
                                .font(.customFont(.callOut))
                                .padding(.bottom, .betweenTextAndLine)
                            Spacer()
                        }
                        .background {
                            Color.white
                        }
                        Divider()
                            .padding(.bottom, .betweenTextAndLine)
                    }
                    .onTapGesture {
                        viewModel.rhType = type
                        isPresented = false
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .presentationDetents([.medium])
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
    
    @ViewBuilder
    private func selectedCapusle(_ value: BloodType.AboType, width: CGFloat) -> some View {
        let width = (width - 64) / 4
        Text(value.rawValue)
            .font(.customFont(.callOut))
            .foregroundStyle(viewModel.aboType == value ? .moduYellow : .disableText)
            .padding(.vertical, 8)
            .frame(width: width)
            .background {
                Capsule()
                    .fill(viewModel.aboType == value ? .moduBlack : .disableCapture)
            }
            .onTapGesture {
                viewModel.aboType = value
            }
    }
}
