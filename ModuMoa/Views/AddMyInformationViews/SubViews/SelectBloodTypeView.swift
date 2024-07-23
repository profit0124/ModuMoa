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
            VStack(alignment: .leading, spacing: .betweenElements) {
                // MARK: Navigation Backbutton
                Image(systemName: "chevron.left")
                    .resizable()
                    .font(.customFont(.headline))
                    .frame(width: 10, height: 20)
                    .padding(.leading, 8)
                    .onTapGesture {
                        if viewModel.caseOfAddMyInfromationView == .bloodType {
                            viewModel.previousButtonTapped()
                        }
                    }
                // MARK: Content
                VStack(alignment: .leading, spacing: .betweenSelectPoint) {
                    VStack(alignment: .leading, spacing: .betweenTitleAndContent) {
                        Text("혈액형을 입력해주세요")
                            .font(.customFont(.largeTitle).bold())
                        
                        VStack(alignment: .leading, spacing: .betweenElements) {
                            HStack {
                                HStack {
                                    let text = viewModel.rhType == nil ? "Rh식" : (viewModel.rhType! == .none ? "Rh식 모름" : viewModel.rhType!.rawValue)
                                    Text(text)
                                    
                                    Image(systemName: "chevron.right")
                                }
                                .font(.customFont(.body))
                                .foregroundStyle(viewModel.rhType == nil ? .disableText : .moduBlack)
                                .onTapGesture {
                                    if !isPresented {
                                        isPresented = true
                                    }
                                }
                                Spacer()
                            }
                            
                            HStack(spacing: 8) {
                                ForEach(BloodType.AboType.allCases, id: \.self) { type in
                                    if type != .none {
                                        selectedCapusle(type, width: width)
                                    }
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: .betweenElements) {
                        ModumoaMemberSectionView(title: "생일", value: viewModel.birthDay.toString())
                        
                        ModumoaMemberSectionView(title: "성별", value: viewModel.sex?.rawValue ?? "모름")
                        
                        ModumoaMemberSectionView(title: "이름", value: viewModel.name)
                    }
                    
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
            VStack(alignment: .leading, spacing: .betweenTitleAndContent) {
                HStack {
                    Text("Rh 식 혈액형을 입력하세요")
                        .font(.customFont(.title2))
                    Spacer()
                }
                VStack(alignment: .leading, spacing: .betweenTextAndLine) {
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
                        }
                        .onTapGesture {
                            viewModel.rhType = type
                            isPresented = false
                        }
                    }
                }
                Spacer()
            }
            .padding(.top, .betweenContents)
            .padding(.horizontal, 16)
            .presentationDetents([.medium])
        }
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
