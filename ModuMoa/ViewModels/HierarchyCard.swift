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
        var addCase: CaseOfAdd?
        var memberAdd: MemberAdd.State?
        
        init(id: String, node: Node) {
            self.id = id
            self.node = node
            self.isPresented = isPresented
            self.children = []
            for child in node.children {
                self.children.append(.init(id: child.member.id.uuidString, node: child))
            }
        }
    }
    
    enum Action: Equatable, BindableAction {
        case viewOnAppear
        case binding(BindingAction<State>)
        case selectNode(Node)
        case addButtonTapped
        case addMember
        case addCase(CaseOfAdd?)
        case changeBaseNode(Node)
        case addParentPartner(Node)
        case memberAdd(MemberAdd.Action)
        indirect case children(id: State.ID, action: Action)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                
            case .viewOnAppear:
                return .none
                
            case .children(id: _, action: let action):
                switch action {
                case .selectNode(let node):
                    return .send(.selectNode(node))
                    
                case .addParentPartner(let node):
                    state.node.partner = node
                    return .none
                    
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
                        if state.node.rightParent != nil {
                            node.partner = state.node.rightParent
                            node.children = state.node.rightParent!.children
                            state.node.rightParent?.partner = node
                            state.node.leftParent = node
                            return .send(.addParentPartner(node))
                        } else {
                            node.children.append(state.node)
                            state.node.leftParent = node
                            return .send(.changeBaseNode(node))
                        }
                        
                        
                    case .rightParent:
                        if state.node.leftParent != nil {
                            node.partner = state.node.leftParent
                            node.children = state.node.leftParent!.children
                            state.node.leftParent?.partner = node
                            state.node.rightParent = node
                            return .send(.addParentPartner(node))
                        } else {
                            node.children.append(state.node)
                            state.node.rightParent = node
                            return .send(.changeBaseNode(node))
                        }
                        
                    case .partner:
                        node.partner = state.node
                        node.children = state.node.children
                        state.node.partner = node
                        
                    default:
                        state.node.children.append(node)
                        if state.node.member.sex == .male {
                            node.leftParent = state.node
                        } else {
                            node.rightParent = state.node
                        }
                        if state.node.partner != nil {
                            state.node.partner?.children.append(node)
                            if state.node.partner?.member.sex == .male {
                                node.leftParent = state.node.partner
                            } else {
                                node.rightParent = state.node.partner
                            }
                        }
                        state.children.append(State(id: node.id.uuidString, node: node))
                    }
                    state.isPushed = false
                    state.memberAdd = nil
                    return .send(.addCase(nil))
                }
                
            case .changeBaseNode, .addParentPartner:
                state.isPushed = false
                state.memberAdd = nil
                return .send(.addCase(nil))
                
                
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
