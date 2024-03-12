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
    @Binding var isLogging: Bool
    @ObservedObject var connectionManager = ConnectionManager()

    @State private var email = ""
    @State private var password = ""
    
    @Binding var isKeyboardVisible: Bool
    @FocusState private var isKeyboardFocused: Bool
    
    @State private var shouldShowImagePicker = false
    @State private var image: UIImage?
    @State private var isLoading = false
    @ObservedObject private var firebaseManager = FirebaseManager.shared

    @State private var showToast = false
    @State private var accountCreatedStatus: ToastOptions = .ACCOUNT_CREATED_FAILED
    private let toastOptions = SimpleToastOptions(
        alignment: .top,
        hideAfter: 2,
        animation: .default,
        modifierType: .slide,
        dismissOnTap: true
    )


    var body: some View {
        VStack {
            if accountCreatedStatus == ToastOptions.WAITING {
                LoadingView()
            } else {
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
                    .foregroundColor(Color("OpositeColor"))
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
                
                Button {
                    accountCreatedStatus = if connectionManager.isActive {
                        if email.isValidEmail() {
                            if password.isValidPassword() {
                                 firebaseManager.createNewAccount(withEmail: email, password: password, image)
                            } else {
                                 ToastOptions.INVALID_PASSWORD
                            }
                        } else {
                             ToastOptions.INVALID_EMAIL
                        }
                    } else {
                        ToastOptions.OFFLINE
                    }
                    
                    showToastIfNotWaiting()
                } label: {
                    HStack {
                        Spacer()
                        Text("create_account").foregroundColor(.white).padding().bold()
                        Spacer()
                    }
                    .background(.blue).cornerRadius(5)
                }
                .padding(.top)
            }
        }
        .padding()
        .simpleToast(isPresented: $showToast, options: toastOptions, onDismiss: {
            isLogging = accountCreatedStatus != .ACCOUNT_CREATED_SUCCESS
        }) {
            ToastPopUpView(text: accountCreatedStatus.rawValue, color: accountCreatedStatus.getColor())
        }
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $image)
        }
        .onChange(of: isKeyboardFocused) {
            isKeyboardVisible = isKeyboardFocused
        }
        .onChange(of: firebaseManager.toastMessage) {
            accountCreatedStatus = firebaseManager.toastMessage
            
            showToastIfNotWaiting()
        }
    }
    
    private func showToastIfNotWaiting() {
        if accountCreatedStatus != ToastOptions.WAITING {
            showToast.toggle()
        }
    }
    
    private var imageOverlay: Color {
        return if image != nil {
            .blue
        } else {
            Color("OpositeColor")
        }
    }
}

private extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
            return self.count >= 4
        }
}

#Preview("English") {
    RegisterView(isLogging: .constant(true), isKeyboardVisible: .constant(false))
        .environment(\.locale, Locale(identifier: "EN"))
}

#Preview("Polish") {
    RegisterView(isLogging: .constant(true), isKeyboardVisible: .constant(false))
        .environment(\.locale, Locale(identifier: "PL"))
}
