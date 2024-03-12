//
//  MainMenuView.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 12/03/2024.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            Circle()
                .fill()
                .foregroundColor(Color.red)
            Text("1")
                .font(.system(size: 150))
                .bold()
        }
    }
}

#Preview {
    MainMenuView()
}
