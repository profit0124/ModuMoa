//
//  InputNameView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/25/23.
//

import SwiftUI

struct InputNameView: View {
    
    @FocusState private var isFocused: Bool
    
    @Binding var viewModel: AddMyInformationViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: .betweenTitleAndContent) {
                Text("이름을 입력해주세요")
                    .font(.customFont(.largeTitle))
                
                ZStack(alignment: .bottom) {
                    TextField("이름", text: $viewModel.name)
                        .focused($isFocused)
                        .keyboardType(.default)
                        .autocorrectionDisabled(true)
                        .font(.customFont(.title1))
                        .padding(2)
                    Color.moduBlack
                        .frame(height: 1)
                }
            }
            .padding(.horizontal, 16)
            
            Spacer()
            
            if !viewModel.name.isEmpty {
                ModumoaRoundedRectangleButton("다음", cornerRadius: 0) {
                    isFocused = false
                    if viewModel.caseOfAddMyInfromationView == .name {
                        viewModel.nextButtonTapped()
                    }
                }
            }
        }
        .padding(.top, .betweenSelectPoint)
        .onAppear {
            isFocused = true
        }
    }
}
//
//#Preview {
//    InputNameView()
//}
