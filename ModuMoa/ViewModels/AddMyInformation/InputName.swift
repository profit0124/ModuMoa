//
//  InputName.swift
//  ModuMoa
//
//  Created by Sooik Kim on 11/15/23.
//

import Foundation
import ComposableArchitecture

struct InputName: Reducer {
    struct State: Equatable {
        private let id: UUID = UUID()
        @BindingState var name: String = ""
        
    }
    
    enum Action: BindableAction, Equatable {
        case nextIndex
        case previousIndex
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }
}
