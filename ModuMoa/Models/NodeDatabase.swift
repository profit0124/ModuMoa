//
//  DatabaseModel.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/22/24.
//

import Foundation
import SwiftData

final class NodeDatabase {
    static let shared: NodeDatabase = .init()
    
    let context: ModelContext
    let dataHandler: DataHandler
    
    init() {
        let container = try! ModelContainer(for: Node.self)
        self.context = ModelContext(container)
        self.dataHandler = DataHandler(container: container)
    }
    
    func fetchNodes() async throws -> [Node] {
        let descriptor = FetchDescriptor<Node>()
        return try await dataHandler.fetch(descriptor)
    }
    
    func fetchNode(_ id: UUID) async -> Node? {
        let descriptor = FetchDescriptor<Node>(predicate: #Predicate<Node>{ $0.id == id })
        return try? await dataHandler.fetch(descriptor).first
    }
    func fetchNode(level: Int, distance: [Int]) async throws -> [Node] {
        let descriptor = FetchDescriptor<Node>(predicate: #Predicate<Node>{ $0.level == level && distance.contains($0.distance) })
        return try await dataHandler.fetch(descriptor)
    }
    
    func addNode(_ node: Node) async throws {
        await dataHandler.insert(node)
        try await dataHandler.save()
    }
    
    func deleteNode(_ node: Node) async throws {
        await dataHandler.delete(node)
        try await dataHandler.save()
    }
    
    func save() async throws {
        try await dataHandler.save()
    }
}
