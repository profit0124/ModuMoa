//
//  SelectGender.swift
//  ModuMoa
//
//  Created by Sooik Kim on 11/22/23.
//

import Foundation
import ComposableArchitecture

struct SelectGender: Reducer {
    struct State: Equatable {
        let id: UUID = UUID()
        var sex: Sex = .none
        let name: String
    }
    
    enum Action: Equatable {
        case nextIndex
        case previousIndex
        case setSex(Sex)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .setSex(sex):
                state.sex = sex
                return .none
                
            default:
                return .none
            }
        }
    }
}
