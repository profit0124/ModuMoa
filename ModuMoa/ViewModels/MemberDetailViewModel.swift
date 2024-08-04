//
//  MemberDetailViewModel.swift
//  ModuMoa
//
//  Created by Sooik Kim on 8/1/24.
//

import Foundation
import Observation

@Observable
final class MemberDetailViewModel {
    var node: Node
    var isPresented: Bool = false
    
    init(node: Node) {
        self.node = node
    }
    
    func updateButtonTapped() {
        isPresented = true
    }
}
