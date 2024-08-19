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
