//
//  Root.swift
//  ModuMoa
//
//  Created by Sooik Kim on 11/23/23.
//

import Foundation
import ComposableArchitecture

enum MainViewCase: Equatable {
    case addMyInformation
    case main
}

struct Root: Reducer {
    struct State: Equatable {
        var id: UUID = UUID()
        var baseNode: Node?
        var addMyInformation: AddMyInformation.State?
        var mainViewCase: MainViewCase = .addMyInformation
        var memberDetail: MemberDetail.State?
        var selectedNode: Node?
        @BindingState var isPresented: Bool = false
    }
    
    enum Action: Equatable, BindableAction {
        case setMainViewCase(MainViewCase)
        case addMyInformation(AddMyInformation.Action)
        case updateMember
        case setSelectedNode(Node)
        case memberDetail(MemberDetail.Action)
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .setMainViewCase(let value):
                state.mainViewCase = value
                return .none
                
            case .addMyInformation(.complete):
                guard let member = state.addMyInformation?.me else { return .none }
                let node = Node(member: member)
                state.baseNode = Node(member: member)
                state.mainViewCase = .main
                return .none
                
            case .setSelectedNode(let node):
                state.selectedNode = node
                state.memberDetail = .init(node: node)
                state.isPresented = true
                return .none
                
            case .memberDetail(.backbuttonTapped):
                state.isPresented = false
                state.memberDetail = nil
                return .none
                
            case .memberDetail(.memberUpdate(.saveButtonTapped(let member))):
                
                return .none
                
            default:
                return .none
                
            }
        }
        .ifLet(\.addMyInformation, action: /Action.addMyInformation) {
            AddMyInformation()
        }
        .ifLet(\.memberDetail, action: /Action.memberDetail) {
            MemberDetail()
        }
    }
    
    
}
