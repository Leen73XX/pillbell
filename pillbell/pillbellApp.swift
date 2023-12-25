//
//  pillbellApp.swift
//  pillbell
//
//  Created by Leen Almejarri on 08/06/1445 AH.
//

import SwiftUI
import SwiftData

@main
struct pillbellApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            splashView()
        }
        .modelContainer(sharedModelContainer)
    }
}
