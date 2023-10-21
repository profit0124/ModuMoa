//
//  HierarchyCardView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/21/23.
//

import SwiftUI

struct HierarchyCardView: View {
    
    @State var me: String
    @State var partner: String?
    @State var childrens:[String] = []
    @State var index:Int = 0
    
    var body: some View {
        VStack(spacing: 80) {
            HStack {
                cardViewWithButton(me)
                    .frame(width: 250)
                
                if let partner {
                    cardViewWithButton(partner)
                        .frame(width: 250)
                }
            }
            
            HStack(alignment: .top) {
                ForEach(childrens, id: \.self) { children in
                    HierarchyCardView(me: children)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(alignment: .top)
    }
    
    @ViewBuilder
    private func cardViewWithButton(_ name: String) -> some View {
        VStack {
            CardView(name: name)
            Button(action: {
                childrens.append("Children\(index)")
                index += 1
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
    HierarchyCardView(me: "Kim", partner: "Partner")
}
