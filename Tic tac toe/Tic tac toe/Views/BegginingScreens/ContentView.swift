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
    @State private var isKeyboardVisible = false
    @State private var isLogging = true
    
    var showAppName = true
    var showContinueAsGuest = true

    var body: some View {
        if isLogging {
            NavigationView {
                ScrollView {
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("login").tag(true)
                        Text("create_account").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle()).padding()
                    
                    if isLoginMode {
                        LoginView(isLogging: $isLogging, isKeyboardVisible: $isKeyboardVisible)
                    } else {
                        RegisterView(isLogging: $isLogging, isKeyboardVisible: $isKeyboardVisible)
                    }
                    
                    if showContinueAsGuest {
                        Button {
                            isLogging = false
                        } label: {
                            Text("continue_as_guest")
                        }
                    }
                }
                .navigationTitle(showAppName ? "APP_NAME" : "")
                .background(Color("BackgroundLoginColor"))
                .overlay(
                    Group {
                        if !isKeyboardVisible {
                            Text(LocalizedStringKey("author"))
                                .foregroundStyle(.gray)
                        }
                    },
                    alignment: .bottom)
                
            }
            .navigationViewStyle(StackNavigationViewStyle())
        } else {
            ToolbarView()
        }
    }
}

#Preview("English") {
    ContentView()
        .environment(\.locale, Locale(identifier: "EN"))
}

#Preview("Polish") {
    ContentView()
        .environment(\.locale, Locale(identifier: "PL"))
//        .task { try? Tips.resetDatastore() }
//        .task {
//            try? Tips.configure([
//                .datastoreLocation(.applicationDefault)
//            ])
//        }
}
