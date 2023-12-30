//
//  Card.swift
//  ModuMoa
//
//  Created by Sooik Kim on 11/11/23.
//

import Foundation
import ComposableArchitecture

struct Card: Reducer {
    
    struct State: Equatable {
        var member: Member
    }
    
    enum Action: Equatable {
        case update(Member)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .update(member):
                state.member = member
                return .none
            }
        }
    }
}
