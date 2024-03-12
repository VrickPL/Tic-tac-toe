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
    @State private var email = ""
    @State private var password = ""
    
    @Binding var isKeyboardVisible: Bool
    @FocusState private var isKeyboardFocused: Bool

    @State private var showToast = false
    @State private var loggedInSuccess = false
    private let toastOptions = SimpleToastOptions(
        alignment: .top,
        hideAfter: 2,
        animation: .default,
        modifierType: .slide,
        dismissOnTap: true
    )


    var body: some View {
        VStack {
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
                loggedInSuccess = FirebaseManager.shared.logIn(withEmail: email, password: password)
                showToast.toggle()
            } label: {
                HStack {
                    Spacer()
                    Text("login").foregroundColor(.white).padding().bold()
                    Spacer()
                }
                .background(.blue).cornerRadius(5)
            }
            .padding()
        }
        .padding()
        .simpleToast(isPresented: $showToast, options: toastOptions, onDismiss: {
            isLogging = !loggedInSuccess
        }) {
            if loggedInSuccess {
                ToastPopUpView(text: "login_success", color: Color.green)
            } else {
                ToastPopUpView(text: "login_failed", color: Color.red)
            }
        }
        .onChange(of: isKeyboardFocused) {
            isKeyboardVisible = isKeyboardFocused
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
