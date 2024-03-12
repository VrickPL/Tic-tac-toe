//
//  LoginView.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 10/03/2024.
//

import SwiftUI
import Firebase
import SimpleToast

struct LoginView: View {
    @Binding var isLogging: Bool
    @ObservedObject var connectionManager = ConnectionManager()

    @State private var email = ""
    @State private var password = ""
    
    @Binding var isKeyboardVisible: Bool
    @FocusState private var isKeyboardFocused: Bool

    @State private var isLoading = false
    @ObservedObject private var firebaseManager = FirebaseManager.shared

    @State private var showToast = false
    @State private var loggedInStatus = ToastOptions.LOGGED_IN_FAILED
    private let toastOptions = SimpleToastOptions(
        alignment: .top,
        hideAfter: 2,
        animation: .default,
        modifierType: .slide,
        dismissOnTap: true
    )


    var body: some View {
        VStack {
            if loggedInStatus == ToastOptions.WAITING {
                LoadingView()
            } else {
                Group {
                    TextField("email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .focused($isKeyboardFocused)
                    SecureField("password", text: $password)
                        .focused($isKeyboardFocused)
                }
                .padding(12)
                .background(Color("TextInputColor"))
                .background(.white)
                .cornerRadius(5)
                
                Button {
                    loggedInStatus = if connectionManager.isActive {
                        firebaseManager.logIn(withEmail: email, password: password)
                    } else {
                        ToastOptions.OFFLINE
                    }
                    
                    showToastIfNotWaiting()
                } label: {
                    HStack {
                        Spacer()
                        Text("login").foregroundColor(.white).padding().bold()
                        Spacer()
                    }
                    .background(.blue).cornerRadius(5)
                }
                .padding(.top)
            }
        }
        .padding()
        .simpleToast(isPresented: $showToast, options: toastOptions, onDismiss: {
            isLogging = loggedInStatus != .LOGGED_IN_SUCCESS
        }) {
            ToastPopUpView(text: loggedInStatus.rawValue, color: loggedInStatus.getColor())
        }
        .onChange(of: isKeyboardFocused) {
            isKeyboardVisible = isKeyboardFocused
        }
        .onChange(of: firebaseManager.toastMessage) {
            loggedInStatus = firebaseManager.toastMessage
            
            showToastIfNotWaiting()
        }
    }
    
    private func showToastIfNotWaiting() {
        if loggedInStatus != ToastOptions.WAITING {
            showToast.toggle()
        }
    }
 }

#Preview("English") {
    LoginView(isLogging: .constant(true), isKeyboardVisible: .constant(false))
        .environment(\.locale, Locale(identifier: "EN"))
}

#Preview("Polish") {
    LoginView(isLogging: .constant(true), isKeyboardVisible: .constant(false))
        .environment(\.locale, Locale(identifier: "PL"))
}
