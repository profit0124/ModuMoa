//
//  MemberUpdate.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/18/24.
//

import Foundation
import ComposableArchitecture

struct MemberUpdate: Reducer {
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        case closeButtonTapped
        case saveButtonTapped(Member)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { _, _ in
            return .none
        }
    }
}
