//
//  Intro.swift
//  ModuMoa
//
//  Created by Sooik Kim on 11/15/23.
//

import Foundation
import ComposableArchitecture


struct Intro: Reducer {
    struct State: Equatable {
        private let id: UUID = UUID()
    }
    
    enum Action: Equatable {
        case nextIndex
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .nextIndex:
                return .none
            }
        }
        
    }
    
}
