//
//  NavigationType.swift
//  ModuMoa
//
//  Created by Sooik Kim on 9/4/24.
//

import SwiftUI

enum NavigationDestination: Hashable {
    case selectNode(Node)
    case addNode(node: Node, caseOfAdd: CaseOfAdd?)
    case serach
}


extension NavigationDestination {
    @ViewBuilder func makeView() -> some View {
        switch self {
        case .selectNode(let node):
            MemberDetailView(node: node)
        case let .addNode(node, caseOfAdd):
            MemberAddView(from: node, with: caseOfAdd)
        case .serach:
            SearchView()
        }
    }
}
