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
    @AppStorage(Keys.selectedThemeKey) private var selectedTheme: Theme = .systemDefault
    @AppStorage(Keys.selectedLanguageKey) private var selectedLanguage: Language = .systemDefault

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .preferredColorScheme(selectedTheme.colorScheme)
                .environment(\.locale, selectedLanguage.locale)
                .task {
                    try? Tips.configure([
                        .datastoreLocation(.applicationDefault)
                    ])
                }
        }
    }
}
