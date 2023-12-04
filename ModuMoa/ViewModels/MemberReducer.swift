//
//  AddMember.swift
//  ModuMoa
//
//  Created by Sooik Kim on 12/4/23.
//

import Foundation
import ComposableArchitecture

struct MemberReducer: Reducer {
    struct State: Identifiable, Equatable {
        let id: String
        @BindingState var memberViewType: MemberViewType
        
        @BindingState var isPresented: Bool = false
        @BindingState var selectedSectionType: SectionType?
        @BindingState var selectedBloodType: SectionType.MemberBloodType?
        @BindingState var name: String = ""
        @BindingState var birthDayString: String = ""
        @BindingState var sexString: String = ""
        @BindingState var bloodTypeToString: String = ""
        @BindingState var aboTypeToString: String = ""
        @BindingState var birthDay: Date = Date()
        @BindingState var sex: Sex?
        @BindingState var aboType: BloodType.AboType?
        @BindingState var rhType: BloodType.RhType?
        
        var member: Member?
        @BindingState var isUpdated: Bool = false
    
        
    }
    
    enum Action: Equatable, BindableAction {
        case onAppear
        case test2
        case binding(BindingAction<State>)
        case setMemberViewType(MemberViewType)
        case tapGesture(_ type: SectionType, _ bloodType: SectionType.MemberBloodType? = nil)
        case setMember
        case dismissAction
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                if state.memberViewType == .detail, let member = state.member {
                    state.name = member.name
                    state.birthDayString = member.birthday?.toString() ?? Date().toString()
                    state.sexString = member.sex.rawValue
                    state.bloodTypeToString = member.bloodType.rh.rawValue
                    state.aboTypeToString = member.bloodType.abo.rawValue
                    state.birthDay = member.birthday ?? Date()
                    state.sex = member.sex
                    state.aboType = member.bloodType.abo
                    state.rhType = member.bloodType.rh
                }
                return .none
                
            case .tapGesture(let type, let bloodType):
                if state.memberViewType != .detail {
                    state.selectedSectionType = type
                    state.selectedBloodType = bloodType
                    state.isPresented = true
                }
                return .none
                
            case .setMemberViewType(let type):
                state.memberViewType = type
                return .none
                
            case .setMember:
                print("inside")
                state.member = Member(name: state.name, bloodType: BloodType(abo: state.aboType!, rh: state.rhType!), sex: state.sex!, birthday: state.birthDay)
                return .none
                
            case .binding(\.$isPresented):
                if !state.isPresented {
                    state.birthDayString = state.birthDay.toString()
                    state.selectedBloodType = nil
                    state.selectedSectionType = nil
                    state.sexString = state.sex?.rawValue ?? ""
                    state.bloodTypeToString = state.rhType?.rawValue ?? ""
                    state.aboTypeToString = state.aboType?.rawValue ?? ""
                    if state.memberViewType == .update {
                        state.isUpdated = checkUpdate(into: &state)
                    }
                }
                return .none
                
            case .binding:
                state.isUpdated = checkUpdate(into: &state)
                return .none
                
            default:
                return .none
            }
        }
    }
    
    private func checkUpdate(into state: inout State) -> Bool {
        if state.member?.name == state.name,
           state.member?.sex == state.sex,
           state.member?.birthday == state.birthDay,
           state.member?.bloodType.rh == state.rhType,
           state.member?.bloodType.abo == state.aboType {
            return false
        } else {
            return true
        }
    }
}
