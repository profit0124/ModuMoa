//
//  HierarchyCardView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/21/23.
//

import SwiftUI

struct HierarchyCardView: View {
    
    @State var parents:[String] = ["", ""]
    @State var childrens:[String] = ["", ""]
    
    var body: some View {
        VStack(spacing: 80) {
            HStack {
                ForEach(parents, id: \.self) { _ in
                    cardViewWithButton()
                        .frame(width: 250)
                }
            }
            
            HStack {
                ForEach(childrens, id: \.self) { _ in
                    cardViewWithButton()
                        .frame(width: 250)
                }
            }
        }
    }
    
    @ViewBuilder
    private func cardViewWithButton() -> some View {
        VStack {
            CardView()
            Button(action: {
                childrens.append("")
            }, label: {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                    .padding(4)
                    .background{
                        Circle()
                            .fill(.disableText)
                    }
            })
        }
    }
}
#Preview {
    HierarchyCardView()
}
