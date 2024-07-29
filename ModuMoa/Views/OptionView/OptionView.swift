//
//  OptionView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/29/24.
//

import SwiftUI

struct OptionView: View {
    
    @Binding var nicknameMode: NicknameMode
    
    @State private var isNicknameButtonTapped: Bool = false
    @State private var isBaseNodeButtonTapped: Bool = false
    
    
    var body: some View {
        HStack(alignment: .top, spacing: .betweenElements) {
            Spacer()
            VStack(spacing: 1) {
                Button(action:{
                    isBaseNodeButtonTapped = false
                    isNicknameButtonTapped.toggle()
                }) {
                    OptionButtonView(name: "arrow.left.arrow.right")
                }
                
                Button(action:{
                    isNicknameButtonTapped = false
                    isBaseNodeButtonTapped.toggle()
                }) {
                    OptionButtonView(name: "figure.stand.line.dotted.figure.stand")
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .topTrailing) {
            ZStack {
                if isNicknameButtonTapped {
                    NicknameOptionView()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.trailing, 48)
        }
        
    }
    
    @ViewBuilder private func NicknameOptionView() -> some View {
        VStack(spacing: 1) {
            ForEach(NicknameMode.allCases, id: \.self) { name in
                Button(action: {
                    UserDefaults.standard.setValue(name.rawValue, forKey: "nicknameMode")
                    nicknameMode = name
                    isNicknameButtonTapped = false
                }) {
                    HStack(spacing: .betweenTextAndLine) {
                        Text(name.rawValue)
                        Spacer()
                        Image(systemName: name.imageName)
                    }
                    .font(.customFont(.caption1))
                    .foregroundStyle(.moduBlack)
                    .padding(.betweenHeadlineAndTitle2)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 20)
                    .background {
                        Color.disableCapture
                    }
                }
                .overlay(alignment: .leading) {
                    if nicknameMode == name {
                        Image(systemName: "checkmark")
                            .font(.customFont(.caption1))
                            .foregroundStyle(.moduBlack)
                            .padding(.leading, 8)
                    }
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.leading, 100)
    }
}

#Preview {
    OptionView(nicknameMode: .constant(.nickname))
}
