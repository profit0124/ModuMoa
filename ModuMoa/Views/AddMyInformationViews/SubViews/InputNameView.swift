//
//  InputNameView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/25/23.
//

import SwiftUI
import ComposableArchitecture

struct InputNameView: View {
    
    @FocusState private var isFocused: Bool
    
    let store: StoreOf<InputName>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { reader in
                let width = reader.size.width
                VStack(alignment: .leading, spacing: 0) {
                    Text("이름을 입력해주세요")
                        .font(.customFont(.largeTitle))
                        .padding(.bottom, .betweenTitleAndContent)
                        ZStack(alignment: .bottom) {
                            TextField("이름", text: viewStore.$name)
                                .focused($isFocused)
                                .keyboardType(.alphabet)
                                .autocorrectionDisabled(true)
                                .font(.customFont(.title1))
                                .padding(2)
                            Color.moduBlack
                                .frame(height: 1)
                    }
                    Spacer()
                    
                }
                .padding(.top, .betweenSelectPoint)
                .padding(.horizontal, 16)
                
                VStack {
                    Spacer()
                    if !viewStore.name.isEmpty {
                        Button(action: {
                            isFocused = false
                            viewStore.send(.nextIndex)
                        }, label: {
                            RoundedRectangleButtonView(title: "다음", cornerRadius: 0)
                                .frame(width: width)
                        })
                    }
                }
                
            }
            .onAppear {
                isFocused = true
            }
        }
        
    }
}
//
//#Preview {
//    InputNameView()
//}
