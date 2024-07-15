//
//  MemberDetail.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/15/24.
//

import Foundation
import ComposableArchitecture

struct MemberDetail: Reducer {
    struct State: Equatable {
        var node: Node
        @BindingState var isPresented: Bool = false
    }
    
    enum Action: Equatable, BindableAction {
        case backbuttonTapped
        case updateButtonTapped
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .backbuttonTapped:
                return .none
                
            case .updateButtonTapped:
                state.isPresented = true
                return .none
                
            default:
                return .none
            }
        }
    }
}
