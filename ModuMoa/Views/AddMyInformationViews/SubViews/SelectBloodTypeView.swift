//
//  SelectBloodTypeView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/29/23.
//

import SwiftUI
import ComposableArchitecture

struct SelectBloodTypeView: View {
    
    let store: StoreOf<SelectBloodType>
    
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
                    VStack(alignment: .leading, spacing: 0) {
                        Text("혈액형을 입력해주세요")
                            .font(.customFont(.largeTitle).bold())
                            .padding(.top, .betweenElements)
                            .padding(.bottom, .betweenTitleAndContent)
                        
                        HStack {
                            Group {
                                if let rhType = viewStore.rhType {
                                    Text(rhType == .none ? "Rh식 모름" : rhType.rawValue)
                                        .font(.customFont(.body))
                                } else {
                                    Text("Rh식")
                                        .font(.customFont(.body))
                                }   
                                Image(systemName: "chevron.right")
                            }
                            .foregroundStyle(viewStore.rhType == nil ? .disableText : .moduBlack)
                            .onTapGesture {
                                if !viewStore.isPresented {
                                    viewStore.send(.setIsPresented(true))
                                }
                            }
                            Spacer()
                        }
                        .padding(.bottom, .betweenElements)
                        
                        HStack(spacing: 8) {
                            ForEach(BloodType.AboType.allCases, id: \.self) { type in
                                if type != .none {
                                    selectedCapusle(type, width: width, viewStore: viewStore)
                                }
                            }
                        }
                        .padding(.bottom, .betweenSelectPoint)
                        
                        makeSection("생일", viewStore.birthDay.toString())
                            .padding(.bottom, .betweenElements)
                        
                        
                        makeSection("성별", viewStore.sex.rawValue)
                            .padding(.bottom, .betweenElements)
                        
                        makeSection("이름", viewStore.name)
                        
                        Spacer()
                    
                        
                        if viewStore.aboType != .none, viewStore.rhType != nil {
                            RoundedRectangleButtonView(title: "완료", isEnabled: true)
                                .onTapGesture {
                                    viewStore.send(.nextIndex)
                                    
                                }
                        } else {
                            RoundedRectangleButtonView(title: "완료", isEnabled: false)
                        }
                        
                        
                    }
                    .padding(.horizontal, 20)
                }
            }
            .sheet(isPresented: viewStore.$isPresented) {
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
                                viewStore.send(.setRhType(type))
                                viewStore.send(.setIsPresented(false))
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                .presentationDetents([.medium])
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
    
    @ViewBuilder
    private func selectedCapusle(_ value: BloodType.AboType, width: CGFloat, viewStore: ViewStore<SelectBloodType.State, SelectBloodType.Action>) -> some View {
        let width = (width - 64) / 4
        Text(value.rawValue)
            .font(.customFont(.callOut))
            .foregroundStyle(viewStore.aboType == value ? .moduYellow : .disableText)
            .padding(.vertical, 8)
            .frame(width: width)
            .background {
                Capsule()
                    .fill(viewStore.aboType == value ? .moduBlack : .disableCapture)
            }
            .onTapGesture {
                viewStore.send(.setAboType(value))
            }
    }
}
