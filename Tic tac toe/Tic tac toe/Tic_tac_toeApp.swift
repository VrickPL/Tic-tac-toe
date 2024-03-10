//
//  Tic_tac_toeApp.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 10/03/2024.
//

import SwiftUI
import TipKit

@main
struct Tic_tac_toeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    try? Tips.configure([
                        .datastoreLocation(.applicationDefault)
                    ])
                }
        }
    }
}
