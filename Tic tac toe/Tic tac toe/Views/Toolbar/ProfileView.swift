//
//  ProfileView.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 12/03/2024.
//

import SwiftUI

struct ProfileView: View {
    @State var isLoggedIn = false


    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            if isLoggedIn {
                Circle()
                    .fill()
                    .foregroundColor(Color.blue)
                Text("2")
                    .font(.system(size: 150))
                    .bold()
            } else {
                ContentView(showAppName: false, showContinueAsGuest: false)
                    .padding(.bottom)
            }
        }
    }
}

#Preview {
    ProfileView()
}
