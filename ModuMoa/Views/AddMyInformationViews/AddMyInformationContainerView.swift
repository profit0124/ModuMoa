//
//  AddMyInformationView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/22/23.
//

import SwiftUI

struct AddMyInformationContainerView: View {
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



