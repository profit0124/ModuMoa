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
        @BindingState var baseNode: Node?
        var addMyInformation: AddMyInformation.State?
        var mainViewCase: MainViewCase = .addMyInformation
        var database: DatabaseModel {
            get {
                DatabaseModel.shared
            }
        }
    }
    
    enum Action: Equatable, BindableAction {
        case setMainViewCase(MainViewCase)
        case addMyInformation(AddMyInformation.Action)
        case setBaseNode(Node?)
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
                state.baseNode = node
                state.mainViewCase = .main
                try? state.database.addNode(node)
                UserDefaults.standard.setValue(node.id.uuidString, forKey: "baseNode")
                return .none
                
            case .setBaseNode(let node):
                state.baseNode = node
                return .none
                
            default:
                return .none
                
            }
        }
        .ifLet(\.addMyInformation, action: /Action.addMyInformation) {
            AddMyInformation()
        }
    }
    
    
}
