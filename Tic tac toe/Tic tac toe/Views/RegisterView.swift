//
//  RegisterView.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 10/03/2024.
//

import SwiftUI
import Firebase
import SimpleToast
import TipKit

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    
    @Binding var isKeyboardVisible: Bool
    @FocusState var isKeyboardFocused: Bool
    
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
    
    
    private var imageOverlay: Color {
        return if image != nil {
            .blue
        } else {
            Color("RegisterImageColor")
        }
    }


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
                .popoverTip(ImageButtonTip(), arrowEdge: .bottom)
                .foregroundColor(Color("RegisterImageColor"))
            }
            .overlay(RoundedRectangle(cornerRadius: 64).stroke(imageOverlay, lineWidth: 3))
            .padding(.bottom)
            
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
            
            VStack {
                Button {
                    if email.isValidEmail() {
                        accountCreated = FirebaseManager.shared.createNewAccount(withEmail: email, password: password, image)
                    } else {
                        accountCreated = ToastOptions.INVALID_EMAIL
                    }

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
        .onChange(of: isKeyboardFocused) {
            isKeyboardVisible = isKeyboardFocused
        }
    }
}

private extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

#Preview("English") {
    RegisterView(isKeyboardVisible: .constant(false))
        .environment(\.locale, Locale(identifier: "EN"))
}

#Preview("Polish") {
    RegisterView(isKeyboardVisible: .constant(false))
        .environment(\.locale, Locale(identifier: "PL"))
}
