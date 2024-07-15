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
        var node: Node
        @BindingState var isPresented: Bool = false
        var children: IdentifiedArrayOf<State> = []
        
        init(id: String, node: Node, isPresented: Bool) {
            self.id = id
            self.node = node
            self.isPresented = isPresented
            self.children = []
            for child in node.children {
                self.children.append(.init(id: child.member.id.uuidString, node: child, isPresented: false))
            }
        }
    }
    
    enum Action: Equatable, BindableAction {
        case viewOnAppear
        case binding(BindingAction<State>)
        case selectNode(Node)
        indirect case children(id: State.ID, action: Action)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                
            case .viewOnAppear:
                print("load partner,chidren data from local data")
                return .none
                
            case .children(id: _, action: let action):
                switch action {
                case .selectNode(let node):
                    return .send(.selectNode(node))
                    
                default:
                    return .none
                }
                
            default:
                return .none
            }
        }
        .forEach(\.children, action: /Action.children(id:action:)){
            HierarchyCard()
        }
    }
}
