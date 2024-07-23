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
        GeometryReader { reader in
            let width = reader.size.width
            VStack(alignment: .leading, spacing: 0) {
                Text("이름을 입력해주세요")
                    .font(.customFont(.largeTitle))
                    .padding(.bottom, .betweenTitleAndContent)
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
                Spacer()
                
            }
            .padding(.top, .betweenSelectPoint)
            .padding(.horizontal, 16)
            
            VStack {
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
            
        }
        .onAppear {
            isFocused = true
        }
    }
        
    
}
//
//#Preview {
//    InputNameView()
//}
