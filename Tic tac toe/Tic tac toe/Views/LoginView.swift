//
//  LoginView.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 10/03/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""


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

            Button {
                // TODO: login
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
