//
//  InputBirtday.swift
//  ModuMoa
//
//  Created by Sooik Kim on 11/22/23.
//

import Foundation
import ComposableArchitecture

struct InputBirthDay: Reducer {
    struct State: Equatable {
        let id: UUID = UUID()
        @BindingState var date: Date = Date()
        let name: String
        let sex: Sex
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case nextIndex
        case previousIndex
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
