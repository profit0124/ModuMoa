//
//  DatabaseModel.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/22/24.
//

import Foundation
import SwiftData

final class DatabaseModel {
    static let shared: DatabaseModel = .init()
    
    let context: ModelContext
    
    init() {
        let container = try! ModelContainer(for: Node.self)
        self.context = ModelContext(container)
    }
    
    func fetchNodes() throws -> [Node] {
        let descriptor = FetchDescriptor<Node>()
        return try context.fetch(descriptor)
    }
    
    func fetchNode(_ id: UUID) -> Node? {
        let descriptor = FetchDescriptor<Node>(predicate: #Predicate<Node>{ $0.id == id })
        return try? context.fetch(descriptor).first
    }
    
    func addNode(_ node: Node) throws {
        context.insert(node)
        try context.save()
    }
    
    func deleteNode(_ node: Node) throws {
        context.delete(node)
        try context.save()
    }
}
