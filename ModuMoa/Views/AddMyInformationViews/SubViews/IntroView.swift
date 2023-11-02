//
//  IntroView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/25/23.
//

import SwiftUI

struct IntroView: View {
    
    @Binding var index: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Image("onboarding")
                .resizable()
                .frame(width: 292, height: 292)
                .padding(.bottom, .betweenTitleAndContent)
            
            Text("모두모아에서")
                .font(.customFont(.headline))
                .padding(.bottom, 5)
            Text("내 가족의 모든 정보를 모아볼 수 있어요")
                .font(.customFont(.headline))
                .padding(.bottom, .largestPadding)
            Button(action: {
                withAnimation {
                    index += 1
                }
            }, label: {
                RoundedRectangleButtonView(title: "확인", cornerRadius: 12)
            })
            
            
                
        }
        .padding(.horizontal, 16)
    }
}
