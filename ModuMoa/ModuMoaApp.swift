//
//  ModuMoaApp.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/9/23.
//

import SwiftUI
import SwiftData

@main
struct ModuMoaApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Node.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false, allowsSave: true)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Coul not create ModelContainer: \(error)")
        }
    } ()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
