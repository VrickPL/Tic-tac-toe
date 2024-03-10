//
//  RegisterView.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 10/03/2024.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""


    var body: some View {
        VStack {
            Button {
                //TODO: load image
            } label: {
                Image(systemName: "person.fill")
                    .font(.system(size: 90))
                    .padding()
                    .foregroundColor(.black)
            }
            .overlay(RoundedRectangle(cornerRadius: 64).stroke(Color.black, lineWidth: 3))
            .padding(.bottom)
            
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
                    // TODO: create new account
                } label: {
                    HStack {
                        Spacer()
                        Text("create_account")
                            .foregroundColor(.white)
                            .padding()
                            .bold()
                        Spacer()
                    }
                    .background(.blue).cornerRadius(5)
                }
            }
            .padding()
        }
        .padding()
    }
}

#Preview("English") {
    RegisterView()
        .environment(\.locale, Locale(identifier: "EN"))
}

#Preview("Polish") {
    RegisterView()
        .environment(\.locale, Locale(identifier: "PL"))
}
