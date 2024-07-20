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
        @BindingState var isPushed: Bool = false
        var children: IdentifiedArrayOf<State> = []
        var addCase: KindOfAdd?
        var memberAdd: MemberAdd.State?
        
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
        case addButtonTapped
        case addMember
        case addCase(KindOfAdd?)
        case memberAdd(MemberAdd.Action)
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
                
            case .addButtonTapped:
                state.isPresented = true
                return .none
                
            case .addMember:
                if let addCase = state.addCase {
                    state.isPresented = false
                    state.memberAdd = .init(addCase: addCase)
                    state.isPushed = true
                }
                return .none
                
            case .addCase(let addCase):
                state.addCase = addCase
                return .none
                
            case .memberAdd(let memberAddAction):
                switch memberAddAction {
                case .backbuttonTapped:
                    state.isPushed = false
                    state.memberAdd = nil
                    return .none
                    
                case .savebuttonTapped(let node):
                    switch state.addCase {
                    case .leftParent:
                        state.node.leftParent = node
                        
                    case .rightParent:
                        state.node.rightParent = node
                        
                    default:
                        state.node.children.append(node)
                        state.children.append(State(id: node.id.uuidString, node: node, isPresented: false))
                    }
                    state.isPushed = false
                    state.memberAdd = nil
                    return .send(.addCase(nil))
                }
                
            default:
                return .none
            }
        }
        .forEach(\.children, action: /Action.children(id:action:)){
            HierarchyCard()
        }
        .ifLet(\.memberAdd, action: /Action.memberAdd) {
            MemberAdd()
        }
    }
}
