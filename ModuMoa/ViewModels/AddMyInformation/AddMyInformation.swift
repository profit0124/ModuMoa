//
//  AddMyInformation.swift
//  ModuMoa
//
//  Created by Sooik Kim on 11/12/23.
//

import Foundation
import ComposableArchitecture

struct AddMyInformation: Reducer {
    struct State: Equatable {
        var id: UUID = UUID()
        var index: Int = 0
        var me: Member = Member(name: "", bloodType: .init(abo: .none, rh: .none), sex: .none, nickName: "나")
        var intro: Intro.State = Intro.State()
        var inputName: InputName.State = InputName.State()
        var selectGender: SelectGender.State?
        var inputBirthDay: InputBirthDay.State?
        var selectBloodType: SelectBloodType.State?
    }
    
    enum Action: Equatable {
        case intro(Intro.Action)
        case inputName(InputName.Action)
        case selectGender(SelectGender.Action)
        case inputBirthDay(InputBirthDay.Action)
        case selectBloodType(SelectBloodType.Action)
        case complete
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .intro(.nextIndex):
                state.index += 1
                return .none
                
            case .inputName(.nextIndex):
                state.me.name = state.inputName.name
                state.selectGender = SelectGender.State(sex: state.me.sex, name: state.me.name)
                state.index += 1
                return .none
                
            case .selectGender(.nextIndex):
                guard let sex = state.selectGender?.sex else { return .none }
                state.me.sex = sex
                state.inputBirthDay = InputBirthDay.State(date: state.me.birthday ?? Date(), name: state.me.name, sex: state.me.sex)
                state.index += 1
                return .none
                
            case .selectGender(.previousIndex), .inputBirthDay(.previousIndex), .selectBloodType(.previousIndex):
                state.index -= 1
                return .none
                
            case .inputBirthDay(.nextIndex):
                state.me.birthday = state.inputBirthDay?.date
                state.selectBloodType = SelectBloodType.State(name: state.me.name, sex: state.me.sex, birthDay: state.me.birthday ?? Date())
                state.index += 1
                return .none
                
            case .selectBloodType(.nextIndex):
                guard let bloodType = state.selectBloodType, let rhType = bloodType.rhType else { return .none }
                let blood = BloodType(abo: bloodType.aboType, rh: rhType)
                state.me.bloodType = blood
                return .send(.complete)
                
            default:
                return .none
            }
        }
        .ifLet(\.selectGender, action: /Action.selectGender) {
            SelectGender()
        }
        .ifLet(\.inputBirthDay, action: /Action.inputBirthDay) {
            InputBirthDay()
        }
        .ifLet(\.selectBloodType, action: /Action.selectBloodType) {
            SelectBloodType()
        }
        Scope(state: \.intro, action: /Action.intro) {
            Intro()
        }
        Scope(state: \.inputName, action: /Action.inputName) {
            InputName()
        }
        
    }
}
