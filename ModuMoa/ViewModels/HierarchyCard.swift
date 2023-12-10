//
//  HierarchyCard.swift
//  ModuMoa
//
//  Created by Sooik Kim on 12/5/23.
//

import Foundation
import ComposableArchitecture

enum DetailMode {
    case me
    case partner
}

enum AddMode {
    case partner
    case children
}

struct HierarchyCard: Reducer {
    struct State: Identifiable, Equatable {
        let id: String
//        var node: TestNode
        var me: Member
        var partner: Member?
        var detailMode: DetailMode?
        var addMode: AddMode?
        var memberReducer: MemberReducer.State?
        @BindingState var isPresented: Bool = false
        var children: IdentifiedArrayOf<State> = []
    }
    
    enum Action: Equatable, BindableAction {
        case viewOnAppear
        case selectedMember(Member)
        case setAddMode(AddMode)
        case addPartner(Member)
        case addChildren(Member)
        case memberReducer(MemberReducer.Action)
        case binding(BindingAction<State>)
        indirect case children(id: State.ID, action: Action)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                
            case .viewOnAppear:
                print("load partner,chidren data from local data")
                return .none
                
            case .setAddMode(let mode):
                state.addMode = mode
                state.memberReducer = MemberReducer.State(id: UUID().uuidString, memberViewType: .add)
                state.isPresented = true
                return .none
                
            case .addPartner(let member):
                state.partner = member
                state.isPresented = false
                return .none
                
            case .addChildren(let member):
                state.children.append(State(id: member.id.uuidString, me: member))
                state.isPresented = false
                return .none
                
            case .selectedMember(let member):
                if member == state.me {
                    state.detailMode = .me
                } else {
                    state.detailMode = .partner
                }
                state.memberReducer = MemberReducer.State(id: member.id.uuidString, memberViewType: .detail, member: member)
                state.isPresented = true
                return .none
                
            case .memberReducer(.setMember):
                if let memberReducer = state.memberReducer, let member = memberReducer.member {
                    if state.detailMode == .me {
                        state.me = member
                    } else {
                        state.partner = member
                    }
                }
                return .none
                
            case .memberReducer(.dismissAction):
                state.isPresented = false
                return .none
                
            case .binding(.set(\.$isPresented, false)):
                if !state.isPresented{
                    state.memberReducer = nil
                }
                return .send(.viewOnAppear)
                
            case .memberReducer(.addMember(let member)):
                if state.addMode == .partner {
                    return .send(.addPartner(member))
                } else {
                    return .send(.addChildren(member))
                }
                
                
            default:
                return .none
            }
        }
        .ifLet(\.memberReducer, action: /Action.memberReducer) {
            MemberReducer()
        }
        .forEach(\.children, action: /Action.children(id:action:)) {
            Self()
        }
    }
}
