//
//  SearchView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/23/24.
//

import SwiftUI

struct SearchView: View {
    
    @State private var viewModel: SearchViewModel = SearchViewModel()
    @Binding var isPushed: Bool
    @State private var isFocused: Bool = false
    
    var body: some View {
        VStack(spacing: .betweenTitleAndContent) {
            HStack {
                Button(action: {
                    isPushed = false
                }) {
                    Image(systemName: "chevron.left")
                        .font(.customFont(.body))
                        .foregroundStyle(.moduBlack)
                        .padding(.horizontal, 4)
                }
                
                SearchBarView(text: $viewModel.text, isFocused: $isFocused)
            }
            
            VStack {
                if !viewModel.text.isEmpty {
                    Text("검색 결과")
                        .font(.callout)
                        .foregroundStyle(.moduBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                if !viewModel.text.isEmpty, viewModel.filteredNodes.isEmpty {
                    VStack(spacing: .betweenHeadlineAndTitle2) {
                        Text("'\(viewModel.text)'에 대한 결과 없음")
                            .font(.customFont(.headline))
                            .foregroundStyle(.moduBlack)
                        
                        Text("맞춤법을 확인하거나 새로운 검색을 시도하십시오.")
                            .font(.customFont(.subHeadline))
                            .foregroundStyle(.disableText)
                    }
                    .padding(.top, .largestPadding)
                    
                } else {
                    ScrollView {
                        LazyVStack(spacing: .betweenElements) {
                            ForEach(viewModel.filteredNodes) { node in
                                CardView(member: node.member)
                                    .onTapGesture {
                                        viewModel.selectedNode = node
                                        viewModel.isPushed = true
                                    }
                            }
                        }
                        .padding(.top, .betweenContents)
                    }
                }
            }
            
            .padding(.horizontal, 16)
            
            Spacer()
        }
        .onAppear {
            isFocused = true
            viewModel.onAppear()
        }
        .onTapGesture {
            isFocused = false
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $viewModel.isPushed) {
            if let node = viewModel.selectedNode {
                MemberDetailView(isPushed: $viewModel.isPushed, node: node)
            }
        }
    }
}

#Preview {
    SearchView(isPushed: .constant(true))
}
