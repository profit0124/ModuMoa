//
//  OptionButtonView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/29/24.
//

import SwiftUI

struct OptionButtonView: View {
    
    let name: String
    
    var body: some View {
        Image(systemName: name)
            .resizable()
            .foregroundStyle(.moduBlack)
            .frame(width: 16, height: 16)
            .padding(10)
            .background {
                Color.disableCapture
            }
    }
}

#Preview {
    OptionButtonView(name: "star.bubble")
}
