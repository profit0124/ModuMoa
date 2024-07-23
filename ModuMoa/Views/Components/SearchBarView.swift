//
//  SearchBarView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/23/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("호칭, 이름", text: $text)
        }
        .font(.customFont(.body))
        .foregroundStyle(.disableText)
        .overlay(alignment: .trailing) {
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.customFont(.body))
                        .foregroundStyle(.disableText)
                        .padding(.trailing, 4)
                }
            }
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
        .background {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.disableCapture)
        }
    }
}

#Preview {
    SearchBarView(text: .constant(""))
}
