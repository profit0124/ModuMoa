//
//  AddMyInformationView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/22/23.
//

import SwiftUI

struct AddMyInformationContainerView: View {
    
    @State var index: Int = 0
    
    @State var name:String = ""
    @State var sex: Sex?
    @State var birthday: Date?
    @State var bloodType: BloodType?
    
    
    
    var body: some View {
        Group {
            switch index {
            case 0:
                IntroView(index: $index)
                    .transition(AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
//                    .animation(.easeInOut, value: 1)
                
            case 1:
                InputNameView(index: $index, bindingName: $name)
                    .transition(AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
//                    .animation(.easeInOut, value: 1)
                
            default:
                Color.black
                    .transition(AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
//                    .animation(.easeInOut, value: 1)
            }
        }
        
    }
    
    @ViewBuilder
    private func makeSection(_ headline: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: .betweenHeadlineAndTitle2) {
            Text(headline)
                .foregroundStyle(.disableText)
                .font(.headline)
                
            Text(value)
                .foregroundStyle(.moduBlack)
                .font(.title2)
        }
        .padding(.bottom, .betweenContents)
    }
}

#Preview {
    AddMyInformationContainerView(name: "", sex: .female, birthday: Date())
}


