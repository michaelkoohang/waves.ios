//
//  WavesApp.swift
//  Waves
//
//  Created by Michael Koohang on 2/13/21.
//

import SwiftUI

@main
struct WavesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
