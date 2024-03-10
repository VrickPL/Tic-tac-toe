//
//  FirebaseManager.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 10/03/2024.
//

import Foundation
import Firebase
import FirebaseStorage
import SwiftUI

class FirebaseManager {
    static let shared = FirebaseManager()
    
    let auth: Auth
    let storage: Storage
    
    private init() {
        FirebaseApp.configure()

        self.auth = Auth.auth()
        self.storage = Storage.storage()
    }
    
    public func logIn(withEmail email: String, password: String) -> Bool {
        var bool = false

        auth.signIn(withEmail: email, password: password) { result, error in
            bool = error == nil
        }
        
        return bool
    }
    
    public func createNewAccount(withEmail email: String, password: String,_ image: UIImage?) -> ToastOptions {
        var toastMessage = ToastOptions.ACCOUNT_CREATED_FAILED

        auth.createUser(withEmail: email, password: password) { result, error in
            let accountCreatedSuccess = error == nil
            
            
            toastMessage = accountCreatedSuccess ? ToastOptions.ACCOUNT_CREATED_SUCCESS : ToastOptions.ACCOUNT_CREATED_FAILED

            let sendImage: ToastOptions? = accountCreatedSuccess ? self.persistImageToStorage(image) : nil
            
            if sendImage != nil && sendImage != ToastOptions.STORED_IMAGE_SUCCESS {
                toastMessage = sendImage!
            }
            
        }
        
        return toastMessage
    }
    
    private func persistImageToStorage(_ image: UIImage?) -> ToastOptions? {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return nil }
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else { return nil }
        
        var toastMessage: ToastOptions? = nil

        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        ref.putData(imageData, metadata: nil) { metadata, error in
            if error == nil {
                ref.downloadURL { url, error in
                    if error == nil {
                        toastMessage = ToastOptions.STORED_IMAGE_SUCCESS
                    } else {
                        toastMessage = ToastOptions.STORED_IMAGE_RETRIEVE_FAILED
                    }
                }
            } else {
                toastMessage = ToastOptions.STORED_IMAGE_PUSH_FAILED
            }
        }
        
        return toastMessage
    }
}
