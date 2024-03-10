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
    @State private var email = ""
    @State private var password = ""

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
                SecureField("password", text: $password)
            }
            .padding(12)
            .background(.white)
            .cornerRadius(5)
            
            VStack {
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
                SignByApple(signUpBool: false)
            }
            .padding()
        }
        .padding()
        .simpleToast(isPresented: $showToast, options: toastOptions, onDismiss: {
            //TODO: login and show new view
        }) {
            if loggedInSuccess {
                ToastPopUpView(text: "login_success", color: Color.green)
            } else {
                ToastPopUpView(text: "login_failed", color: Color.red)
            }
        }
    }
    
    
 }

#Preview("English") {
    LoginView()
        .environment(\.locale, Locale(identifier: "EN"))
}

#Preview("Polish") {
    LoginView()
        .environment(\.locale, Locale(identifier: "PL"))
}
