//
//  LoadingView.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 12/03/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .backgroundStyle(Color("BackgroundColor"))
    }
}

#Preview {
    LoadingView()
}
