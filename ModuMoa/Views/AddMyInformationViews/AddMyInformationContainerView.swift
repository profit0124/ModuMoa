//
//  AddMyInformationView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/22/23.
//

import SwiftUI
import Combine

struct AddMyInformationContainerView: View {
    
//    @Binding var rootNode: Node?
    
//    @State var index: Int = 0
    
//    @State var name:String = ""
//    @State var sex: Sex?
//    @State var birthday: Date = Date()
//    @State var bloodType: BloodType?
    
//    let store: StoreOf<AddMyInformation>
    @State private var viewModel: AddMyInformationViewModel = AddMyInformationViewModel()
    
    var body: some View {
        Group {
            switch viewModel.caseOfAddMyInfromationView {
            case .intro:
                IntroView(viewModel: $viewModel)
            case .name:
                InputNameView(viewModel: $viewModel)
            case .sex:
                SelectGenderView(viewModel: $viewModel)
            case .birthday:
                InputBirthdayView(viewModel: $viewModel)
            case .bloodType:
                SelectBloodTypeView(viewModel: $viewModel)
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



