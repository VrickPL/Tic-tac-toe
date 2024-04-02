//
//  ProfileImageView.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 15/03/2024.
//

import SwiftUI

struct ProfileImageView: View {
    @Binding var image: UIImage?


    var body: some View {
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
        .overlay(RoundedRectangle(cornerRadius: 64).stroke(imageOverlayColor, lineWidth: 3))
        .padding(.bottom)
    }
    
    private var imageOverlayColor: Color {
        return if image != nil {
            .blue
        } else {
            Color("OpositeColor")
        }
    }
}

#Preview {
    ProfileImageView(image: .constant(nil))
}
