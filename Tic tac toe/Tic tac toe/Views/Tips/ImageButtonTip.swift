//
//  ImageButtonTip.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 10/03/2024.
//

import Foundation
import TipKit

struct ImageButtonTip: Tip {
    var title = Text(LocalizedStringKey("image_button_tip_title"))
    var message: Text? = Text(LocalizedStringKey("image_button_tip_message"))
    var image: Image? = Image(systemName: "photo.circle")
}
