//
//  RoundedRectangleButtonView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/25/23.
//

import SwiftUI

struct RoundedRectangleButtonView: View {
    
    var title: String = "다음"
    var cornerRadius: CGFloat = 8
    @State var isEnabled: Bool = true
    
    var body: some View {
        Text(title)
            .font(.customFont(.callOut))
            .foregroundStyle(isEnabled ? .moduYellow :  .disableText)
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background{
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(isEnabled ? .moduBlack : .disableCapture)
            }
            
    }
}

#Preview {
    RoundedRectangleButtonView()
}
