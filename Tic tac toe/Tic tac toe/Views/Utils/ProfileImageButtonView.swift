//
//  ProfileImageView.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 15/03/2024.
//

import SwiftUI

struct ProfileImageButtonView: View {
    @Binding var image: UIImage?
    @State private var shouldShowImagePicker = false


    var body: some View {
        VStack {
            Button {
                shouldShowImagePicker.toggle()
            } label: {
                ProfileImageView(image: $image)
            }
            
        }
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $image)
        }
    }
}

#Preview {
    ProfileImageButtonView(image: .constant(nil))
}
