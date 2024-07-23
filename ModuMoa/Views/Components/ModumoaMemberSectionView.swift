//
//  ModumoaMemberSection.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/23/24.
//

import SwiftUI

struct ModumoaMemberSectionView: View {
    
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: .betweenHeadlineAndTitle2) {
            Text(title)
                .font(.customFont(.callOut))
                .foregroundStyle(.grayscale1)
            
            Text(value)
                .font(.customFont(.body))
                .foregroundStyle(.moduBlack)
        }
    }
}

#Preview {
    ModumoaMemberSectionView(title: "", value: "")
}
