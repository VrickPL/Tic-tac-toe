//
//  ToastPopUpView.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 10/03/2024.
//

import SwiftUI

struct ToastPopUpView: View {
    @State var text: String
    @State var color: Color?
    
    var body: some View {
        VStack {
            Text(LocalizedStringKey(text))
        }
        .padding(20)
        .background(color)
        .opacity(0.8)
        .foregroundColor(.white)
        .cornerRadius(14)
    }
}

#Preview {
    ToastPopUpView(text: "account_created_success", color: .green)
}
