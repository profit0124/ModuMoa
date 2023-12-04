//
//  AddMyInformationView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/22/23.
//

import SwiftUI
import Combine
import ComposableArchitecture

struct AddMyInformationContainerView: View {
    
//    @Binding var rootNode: Node?
    
//    @State var index: Int = 0
    
//    @State var name:String = ""
//    @State var sex: Sex?
//    @State var birthday: Date = Date()
//    @State var bloodType: BloodType?
    
    let store: StoreOf<AddMyInformation>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Group {
                switch viewStore.index {
                case 0:
                    IntroView(store: self.store.scope(state: \.intro, action: AddMyInformation.Action.intro))
                    
                case 1:
                    InputNameView(store: self.store.scope(state: \.inputName, action: AddMyInformation.Action.inputName))
                    
                case 2:
                    IfLetStore(self.store.scope(state: \.selectGender, action: AddMyInformation.Action.selectGender), then: {
                        SelectGenderView(store: $0)
                    })

                case 3:
                    IfLetStore(self.store.scope(state: \.inputBirthDay, action: AddMyInformation.Action.inputBirthDay), then: {
                        InputBirthdayView(store: $0)
                    })
                    
                case 4:
                    IfLetStore(self.store.scope(state: \.selectBloodType, action: AddMyInformation.Action.selectBloodType), then: {
                        SelectBloodTypeView(store: $0)
                    })
                    
                default:
                    Color.black
                        .transition(AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
            .onAppear{
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



