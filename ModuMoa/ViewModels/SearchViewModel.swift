//
//  SearchViewModel.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/23/24.
//

import Foundation
import Observation

@Observable
final class SearchViewModel {
    var text: String = ""
    var nodes: [Node] = []
    var selectedNode: Node?
    var isPushed: Bool = false
    
    var filteredNodes: [Node] {
        self.nodes.filter({ $0.member.name.contains(self.text) || $0.member.nickNames.nickname.contains(self.text) })
    }
    
    func onAppear() {
        Task {
            do {
                self.nodes = try await NodeDatabase.shared.fetchNodes()
            } catch {
                print("Error")
            }
        }
    }
}
