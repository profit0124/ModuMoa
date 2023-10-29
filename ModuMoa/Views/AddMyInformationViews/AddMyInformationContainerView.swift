//
//  AddMyInformationView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/22/23.
//

import SwiftUI

struct AddMyInformationContainerView: View {
    
    @Binding var rootNode: Node?
    
    @State var index: Int = 0
    
    @State var name:String = ""
    @State var sex: Sex?
    @State var birthday: Date = Date()
    @State var bloodType: BloodType?
    
    
    
    var body: some View {
        Group {
            switch index {
            case 0:
                IntroView(index: $index)
                    .transition(AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                
            case 1:
                InputNameView(index: $index, bindingName: $name)
                    .transition(AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                
            case 2:
                SelectGenderView(sex: $sex, name: $name, index: $index)
                
            case 3:
                InputBirthdayView(index: $index, birthday: $birthday, sex: $sex, name: $name)
                
            case 4:
                SelectBloodTypeView(name: $name,
                                    sex: $sex,
                                    birthDay: $birthday,
                                    bloodType: $bloodType, index: $index)
                
            case 5:
                Color.black
                    .onAppear {
                        self.rootNode = Node(member: Member(name: name, bloodType: bloodType!, sex: sex!, birthday: birthday))
                    }
                
            default:
                Color.black
                    .transition(AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
        }
        .onAppear{
            print(sex)
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
    AddMyInformationContainerView(rootNode: .constant(nil), name: "", sex: .female, birthday: Date())
}


