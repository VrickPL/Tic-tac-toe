//
//  Theme.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 02/04/2024.
//

import SwiftUI

enum Theme: String, CaseIterable {
    case systemDefault = "auto"
    case light = "light"
    case dark = "dark"
    
    var colorScheme: ColorScheme? {
        return switch self {
        case .systemDefault:
            nil
        case .light:
            .light
        case .dark:
            .dark
        }
    }
}
