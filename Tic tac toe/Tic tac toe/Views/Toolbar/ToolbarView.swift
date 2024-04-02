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
            VStack {
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
        .background(Color("BackgroundColor"))
    }
}

#Preview {
    ToolbarView()
}
