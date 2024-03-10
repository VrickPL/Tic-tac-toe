//
//  ContentView.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 10/03/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoginMode = false

    var body: some View {
        NavigationView {
            ScrollView {
                Picker(selection: $isLoginMode, label: Text("Picker here")) {
                    Text("login").tag(true)
                    Text("create_account").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle()).padding()

                if isLoginMode {
                    LoginView()
                } else {
                    RegisterView()
                }

            }
            .navigationTitle(isLoginMode ? "login" : "create_account")
            .background(Color(.init(white: 0, alpha: 0.05)))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview("English") {
    ContentView()
        .environment(\.locale, Locale(identifier: "EN"))
}

#Preview("Polish") {
    ContentView()
        .environment(\.locale, Locale(identifier: "PL"))
}
