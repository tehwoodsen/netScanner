//
//  NetScannerApp.swift
//  NetScanner
//
//  Created by Erik Woods on 4/23/25.
//

import SwiftUI

@main
struct NetScannerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
