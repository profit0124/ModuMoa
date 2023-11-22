//
//  SelectBloodType.swift
//  ModuMoa
//
//  Created by Sooik Kim on 11/22/23.
//

import Foundation
import ComposableArchitecture

struct SelectBloodType: Reducer {
    struct State: Equatable {
        let id: UUID = UUID()
        var aboType: BloodType.AboType = .none
        var rhType: BloodType.RhType?
        
        let name: String
        let sex: Sex
        let birthDay: Date
        @BindingState var isPresented: Bool = false
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case setRhType(BloodType.RhType)
        case setAboType(BloodType.AboType)
        case setIsPresented(Bool)
        case previousIndex
        case nextIndex
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce{ state, action in
            switch action {
            case let .setIsPresented(value):
                state.isPresented = value
                return .none
                
            case let .setRhType(value):
                state.rhType = value
                return .none
                
            case let .setAboType(value):
                state.aboType = value
                return .none
                
            default:
                return .none
            }
        }
    }
}
