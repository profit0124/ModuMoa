//
//  RoundedRectangleButtonView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/25/23.
//

import SwiftUI

struct RoundedRectangleButtonView: View {
    
    var title: String = "확인"
    var cornerRadius: CGFloat = 8
    
    var body: some View {
        Text(title)
            .font(.customFont(.callOut))
            .foregroundStyle(.moduYellow)
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background{
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.moduBlack)
            }
            
    }
}

#Preview {
    RoundedRectangleButtonView()
}
