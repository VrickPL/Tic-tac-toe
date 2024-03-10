//
//  SignByAppleView.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 10/03/2024.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct SignByApple: View {
    @Environment(\.colorScheme) var colorScheme
    @State var signUpBool = true
    
    var body: some View {
        VStack {
            if signUpBool {
                SignInWithAppleButton(.signUp, onRequest: configure, onCompletion: handle)
            } else {
                SignInWithAppleButton(.signIn, onRequest: configure, onCompletion: handle)
            }
        }
        .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
            .frame(height: 45)
    }
    
    func configure(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
        //TODO: implement
    }
    
    func handle(_ authResult: Result<ASAuthorization, Error>) {
        //TODO: implement
    }
}

#Preview {
    SignByApple()
}
