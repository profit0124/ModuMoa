//
//  FullScreenType.swift
//  ModuMoa
//
//  Created by Sooik Kim on 9/4/24.
//

import SwiftUI

enum FullScreenDestination: Hashable, Identifiable {
    case updateNode(Node)
    
    var id: String {
        String(describing: self)
    }
}

extension FullScreenDestination {
    @ViewBuilder func makeView() -> some View {
        switch self {
        case .updateNode(let node):
            MemberUpdateView(node: node)
        }
    }
}
