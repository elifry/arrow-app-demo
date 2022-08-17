//
//  Arrow_App_ExerciseApp.swift
//  Arrow App Exercise
//
//  Created by Elijah Fry on 8/17/22.
//

import SwiftUI

@main
struct Arrow_App_ExerciseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
