//
//  ClockApp.swift
//  Clock
//
//  Created by cole cabral on 2021-08-29.
//

import SwiftUI

@main
struct ClockApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
