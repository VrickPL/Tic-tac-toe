//
//  RegisterView.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 10/03/2024.
//

import SwiftUI
import Firebase
import SimpleToast

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    
    @State private var shouldShowImagePicker = false
    @State var image: UIImage?

    @State private var showToast = false
    @State private var accountCreated: ToastOptions = .ACCOUNT_CREATED_FAILED
    private let toastOptions = SimpleToastOptions(
        alignment: .top,
        hideAfter: 2,
        animation: .default,
        modifierType: .slide,
        dismissOnTap: true
    )


    var body: some View {
        
        VStack {
            Button {
                shouldShowImagePicker.toggle()
            } label: {
                VStack {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 128, height: 128)
                            .cornerRadius(64)
                    } else {
                        Image(systemName: "person.fill").font(.system(size: 90)).padding()
                    }
                }
                .foregroundColor(.black)
            }
            .overlay(RoundedRectangle(cornerRadius: 64).stroke(Color.black, lineWidth: 3))
            
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
                    accountCreated = FirebaseManager.shared.createNewAccount(withEmail: email, password: password, image)
                    showToast.toggle()
                } label: {
                    HStack {
                        Spacer()
                        Text("create_account").foregroundColor(.white).padding().bold()
                        Spacer()
                    }
                    .background(.blue).cornerRadius(5)
                }
            }.padding()
        }
        .padding()
        .simpleToast(isPresented: $showToast, options: toastOptions, onDismiss: {
            //TODO: login and show new view
        }) {
            ToastPopUpView(text: accountCreated.rawValue, color: accountCreated.getColor())
        }
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $image)
        }
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
