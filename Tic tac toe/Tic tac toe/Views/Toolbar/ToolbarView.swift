//
//  ToolbarView.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 12/03/2024.
//

import SwiftUI

struct ToolbarView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                        }
                        .padding(.trailing)
                    }
                    
                    TabView {
                        Group {
                            MainMenuView()
                                .tabItem {
                                    Image(systemName: "house")
                                    Text("home")
                                }
                            
                            ProfileView()
                                .tabItem {
                                    Image(systemName: "person")
                                    Text("profile")
                                }
                        }
                        .toolbarBackground(Color("ToolbarBackgroundColor"), for: .tabBar)
                        .toolbarBackground(.visible, for: .tabBar)
                    }
                }
            }
        }
    }
}

#Preview {
    ToolbarView()
}
