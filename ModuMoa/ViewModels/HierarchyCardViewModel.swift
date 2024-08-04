//
//  HierarchyCardViewModel.swift
//  ModuMoa
//
//  Created by Sooik Kim on 8/1/24.
//

import Foundation

@Observable
final class HierarchyCardViewModel {
    var node: Node
    var isPresented: Bool = false
    var selectedAddCase: CaseOfAdd?
    var addNodeViewisPushed: Bool = false {
        didSet {
            if !addNodeViewisPushed {
                selectedNode = nil
                selectedAddCase = nil
            }
        }
    }
    var detailNodeViewIsPushed: Bool = false
    var fromMe: Bool = true
    var selectedNode: Node?
    
    init(node: Node) {
        self.node = node
    }
    
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
//            if let partner = self.node.partner {
//                let children = Array(Set(node.children + partner.children).sorted(by: { $0.member.birthday ?? Date() <= $1.member.birthday ?? Date()}))
//                node.children = partner.children
//                node.partner?.children = children
//            }
            
            if self.node.member.nickNames.nickname.isEmpty {
                self.node.setNickname()
            }
            
            if let partner = self.node.partner, partner.member.nickNames.nickname.isEmpty {
                partner.setNickname()
            }
        }
    }
    
    func detailButtonTapped(_ node: Node) {
        self.selectedNode = node
        self.detailNodeViewIsPushed = true
    }
    
    func plusButtonTapped(_ node: Node) {
        self.selectedNode = node
        self.isPresented = true
    }
    
    func setSelectedAddCase(_ caseOfAdd: CaseOfAdd?) {
        self.selectedAddCase = caseOfAdd
    }
    
    func addButtonTapped() {
        self.isPresented = false
        self.addNodeViewisPushed = true
    }
    
    
}
