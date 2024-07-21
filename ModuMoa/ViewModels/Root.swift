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
    case detail
}

struct Root: Reducer {
    struct State: Equatable {
        var id: UUID = UUID()
        var baseNode: Node?
        var selectedMember: Member?
        var addMyInformation: AddMyInformation.State?
        var mainViewCase: MainViewCase = .addMyInformation
        var memberReducer: MemberReducer.State?
        var hierarchyCard: HierarchyCard.State?
        var memberDetail: MemberDetail.State?
        var selectedNode: Node?
        @BindingState var isPresented: Bool = false
    }
    
    enum Action: Equatable, BindableAction {
        case setMainViewCase(MainViewCase)
        case addMyInformation(AddMyInformation.Action)
        case setSelectedMember(Member?)
        case updateMember
        case memberReducer(MemberReducer.Action)
        case hierarchyCard(HierarchyCard.Action)
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
                state.hierarchyCard = HierarchyCard.State(id: node.id.uuidString, node: node)
                state.mainViewCase = .main
                return .none
                
            case .setSelectedMember(let member):
                state.selectedMember = member
                if member != nil {
                    return .send(.updateMember)
                } else {
                    return .none
                }
            
            case .updateMember:
                state.memberReducer = MemberReducer.State(id: state.selectedMember!.id.uuidString, memberViewType: .detail, member: state.selectedMember)
                return .none
                
            case .memberReducer(.setMember):
                state.selectedMember = state.memberReducer?.member
                return .none
                
            case .memberReducer(.dismissAction):
                state.mainViewCase = .main
                state.selectedMember = state.memberReducer?.member
                state.baseNode?.member = state.selectedMember!
                state.memberReducer = nil
                return .none
                
            case .hierarchyCard(.selectNode(let node)):
                state.memberDetail = .init(node: node)
                state.isPresented = true
                return .none
                
            case .memberDetail(.backbuttonTapped):
                state.isPresented = false
                state.memberDetail = nil
                return .none
                
            case .memberDetail(.memberUpdate(.saveButtonTapped(let member))):
                state.baseNode?.member = member
                return .none
                
            default:
                return .none
                
            }
        }
        .ifLet(\.addMyInformation, action: /Action.addMyInformation) {
            AddMyInformation()
        }
        .ifLet(\.memberReducer, action: /Action.memberReducer) {
            MemberReducer()
        }
        .ifLet(\.hierarchyCard, action: /Action.hierarchyCard) {
            HierarchyCard()
        }
        .ifLet(\.memberDetail, action: /Action.memberDetail) {
            MemberDetail()
        }
    }
}
