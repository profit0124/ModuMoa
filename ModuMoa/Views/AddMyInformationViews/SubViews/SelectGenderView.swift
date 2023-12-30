//
//  SelectGenderView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/28/23.
//

import SwiftUI
import ComposableArchitecture

struct SelectGenderView: View {
    
    let store: StoreOf<SelectGender>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { reader in
                let width = reader.size.width
                VStack(alignment: .leading, spacing: 0) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .font(.customFont(.headline))
                        
                        .frame(width: 10, height: 20)
                        .onTapGesture {
                            viewStore.send(.previousIndex)
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
                                if value != .none {
                                    selectedCapule(value, width: width, viewStore: viewStore)
                                }
                            }
                        }
                        .padding(.bottom, .betweenSelectPoint)
                        
                        makeSection("이름", viewStore.name)
                        
                        Spacer()
                        
                        if viewStore.sex != .none {
                            RoundedRectangleButtonView(title: "다음", isEnabled: true)
                                .onTapGesture {
                                    viewStore.send(.nextIndex)
                                }
                        } else {
                            RoundedRectangleButtonView(title: "다음", isEnabled: false)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            .frame(maxWidth: .infinity)
        }
        
        
        
    }
    
    @ViewBuilder
    private func selectedCapule(_ value: Sex, width: CGFloat, viewStore: ViewStore<SelectGender.State, SelectGender.Action>) -> some View {
        let width = (width - 44) / 4
        Text(value.rawValue)
            .font(.customFont(.callOut))
            .foregroundStyle(viewStore.sex == value ? .moduYellow : .disableText)
            .padding(.vertical, 8)
            .frame(width: width)
            .background {
                Capsule()
                    .fill(viewStore.sex == value ? .moduBlack : .disableCapture)
            }
            .onTapGesture {
                viewStore.send(.setSex(value))
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
