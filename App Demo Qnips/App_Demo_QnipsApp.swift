//
//  App_Demo_QnipsApp.swift
//  App Demo Qnips
//
//  Created by Timo Kurtz on 11.04.23.
//

import SwiftUI

@main
struct App_Demo_QnipsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
