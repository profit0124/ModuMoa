//
//  MemberAdd.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/20/24.
//

import Foundation
import ComposableArchitecture


struct MemberAdd: Reducer {
    struct State: Equatable {
        
    }
    
    enum Action {
        case backbuttonTapped
        case savebuttonTapped(Node)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { _, _ in
            return .none
        }
    }
}
