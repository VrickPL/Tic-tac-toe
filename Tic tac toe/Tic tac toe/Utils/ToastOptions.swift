//
//  ToastOptions.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 10/03/2024.
//

import Foundation
import SwiftUI

enum ToastOptions: String {
    case ACCOUNT_CREATED_SUCCESS = "account_created_success"
    case ACCOUNT_CREATED_FAILED = "account_created_failed"
    case STORED_IMAGE_SUCCESS = "stored_image_success"
    case STORED_IMAGE_RETRIEVE_FAILED = "stored_image_retrieve_failed"
    case STORED_IMAGE_PUSH_FAILED = "stored_image_push_failed"
    case INVALID_EMAIL = "invalid_email"
    case INVALID_PASSWORD = "invalid_password"
    case WAITING = "waiting"
    case OFFLINE = "offline"
    case LOGGED_IN_SUCCESS = "login_success"
    case LOGGED_IN_FAILED = "login_failed"
    
    func getColor() -> Color {
        return switch self {
        case .ACCOUNT_CREATED_SUCCESS, .STORED_IMAGE_SUCCESS, .LOGGED_IN_SUCCESS:
            Color.green
        default:
            Color.red
        }
    }
}
