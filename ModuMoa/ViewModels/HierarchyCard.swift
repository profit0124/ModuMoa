//
//  HierarchyCard.swift
//  ModuMoa
//
//  Created by Sooik Kim on 12/5/23.
//

import Foundation
import ComposableArchitecture

struct HierarchyCard: Reducer {
    struct State: Identifiable, Equatable {
        let id: String
//        var node: TestNode
        var me: Member
        var partner: Member?
        var children: IdentifiedArrayOf<State> = []
    }
    
    enum Action: Equatable {
        case selectedMember(Member)
        case viewOnAppear
        case addPartner
        case addChildren(Member)
        indirect case children(id: State.ID, action: Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .viewOnAppear:
                print("load partner,chidren data from local data")
                return .none
                
            case .addPartner:
                state.partner = Member(name: "partner", bloodType: BloodType(abo: .A, rh: .negative), sex: .female)
                return .none
                
            case .addChildren(let member):
                state.children.append(State(id: member.id.uuidString, me: member))
                return .none
                
            default:
                return .none
            }
        }
        .forEach(\.children, action: /Action.children(id:action:)) {
            Self()
        }
    }
}
