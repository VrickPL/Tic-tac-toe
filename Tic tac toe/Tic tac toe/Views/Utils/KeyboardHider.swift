//
//  KeyboardHider.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 14/03/2024.
//

import Foundation
import SwiftUI

func hideKeyboard() {
    UIApplication
        .shared
        .sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
