//
//  IntroView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/25/23.
//

import SwiftUI

struct IntroView: View {
    
    @Binding var viewModel: AddMyInformationViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: .largestPadding) {
                VStack(spacing: .betweenTitleAndContent) {
                    Image("onboarding")
                        .resizable()
                        .frame(width: 292, height: 292)
                    
                    VStack(spacing: 5) {
                        Text("모두모아에서")
                            .font(.customFont(.headline))
                        
                        Text("내 가족의 모든 정보를 모아볼 수 있어요")
                            .font(.customFont(.headline))
                    }
                }
                
                ModumoaRoundedRectangleButton("다음", cornerRadius: 12) {
                    if viewModel.caseOfAddMyInfromationView == .intro {
                        viewModel.nextButtonTapped()
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
}
