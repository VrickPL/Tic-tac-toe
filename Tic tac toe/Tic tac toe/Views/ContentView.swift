//
//  ContentView.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 10/03/2024.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @State private var isLoginMode = false
    @State var isKeyboardVisible = false

    var body: some View {
        NavigationView {
            ScrollView {
                Picker(selection: $isLoginMode, label: Text("Picker here")) {
                    Text("login").tag(true)
                    Text("create_account").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle()).padding()

                if isLoginMode {
                    LoginView(isKeyboardVisible: $isKeyboardVisible)
                } else {
                    RegisterView(isKeyboardVisible: $isKeyboardVisible)
                }

            }
            .navigationTitle("APP_NAME")
            .background(Color(.init(white: 0, alpha: 0.05)))
            .overlay(
                Group {
                    if !isKeyboardVisible {
                        Text(LocalizedStringKey("author"))
                            .foregroundStyle(.gray)
                    }
                }
            , alignment: .bottom)
            
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
        .task { try? Tips.resetDatastore() }
        .task {
            try? Tips.configure([
                .datastoreLocation(.applicationDefault)
            ])
        }
}
