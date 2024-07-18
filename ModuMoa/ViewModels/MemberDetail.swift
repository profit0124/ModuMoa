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
        var memberUpdate: MemberUpdate.State?
        @BindingState var isPresented: Bool = false
    }
    
    enum Action: Equatable, BindableAction {
        case backbuttonTapped
        case updateButtonTapped
        case closeFullScreencover
        case memberUpdate(MemberUpdate.Action)
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .backbuttonTapped:
                return .none
                
            case .updateButtonTapped:
                state.memberUpdate = .init()
                state.isPresented = true
                return .none
                
            case .memberUpdate(let updateAction):
                switch updateAction {
                case .closeButtonTapped:
                    return .send(.closeFullScreencover)
                    
                case .saveButtonTapped(let member):
                    state.node.member = member
                    return .send(.closeFullScreencover)
                }
                
            case .closeFullScreencover:
                state.isPresented = false
                state.memberUpdate = nil
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.memberUpdate, action: /Action.memberUpdate) {
            MemberUpdate()
        }
    }
}
