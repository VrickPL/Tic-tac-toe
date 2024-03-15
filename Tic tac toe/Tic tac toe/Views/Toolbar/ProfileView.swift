//
//  ProfileView.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 12/03/2024.
//

import SwiftUI

struct ProfileView: View {
    @State var isLoggedIn = true

    @State var image: UIImage?
    @State var name: String?
    @State var surname: String?
    @State var bio: String?
    @State var email: String?


    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            if isLoggedIn {
                VStack {
                    ProfileImageView(image: $image)
                    
                    fullNameText
                        .padding(.bottom)
                    if let bio = bio {
                        Text(bio)
                    }
                    emailText
                    
                    Button {
                        // showPreviousGames()
                    } label: {
                        Text("edit_profile")
                            .tint(.white)
                            .padding()
                            .background(Color(.gray))
                            .cornerRadius(15)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button {
                        // editProfile()
                    } label: {
                        Text("show_previous_games")
                            .tint(.white)
                            .padding()
                            .background(Color(.blue))
                            .cornerRadius(15)
                    }
                    .padding()
                }
                .padding()
            } else {
                ContentView(showAppName: false, showContinueAsGuest: false)
                    .padding(.bottom)
            }
        }
    }
    
    private var fullNameText: Text {
        var text: String = ""

        if let name = name {
            text += name
        }
        if let surname = surname {
            text += surname
        }

        return if text.isEmpty {
            Text("name_and_surname")
                .font(.title)
                .foregroundStyle(.gray)
                .underline()
        } else {
            Text(text)
                .font(.title)
        }
    }
    
    private var emailText: Text {
        return if let email = email {
            Text(email)
        } else {
            Text("email")
                .foregroundStyle(.gray)
                .underline()
        }
    }
}

#Preview {
    ProfileView()
}
