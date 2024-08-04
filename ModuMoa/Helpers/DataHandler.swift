//
//  DataHandler.swift
//  ModuMoa
//
//  Created by Sooik Kim on 8/4/24.
//

import Foundation
import SwiftData

@ModelActor
actor DataHandler {
    public init(container: ModelContainer) {
        let modelContext = ModelContext(container)
        self.modelExecutor = DefaultSerialModelExecutor(modelContext: modelContext)
        self.modelContainer = container
    }
    
    public func delete(_ model: some PersistentModel) async {
        self.modelContext.delete(model)
    }
    
    public func insert(_ model: some PersistentModel) async {
        self.modelContext.insert(model)
    }
    
    public func save() async throws {
        try self.modelContext.save()
    }
    
    public func fetch<T>(_ descriptor: FetchDescriptor<T>) async throws -> [T] where T: PersistentModel {
        return try self.modelContext.fetch(descriptor)
    }
    
    public func fetchItem<T>(_ identifier: PersistentIdentifier) async -> T? where T: PersistentModel {
        return self.modelContext.registeredModel(for: identifier)
    }
}
