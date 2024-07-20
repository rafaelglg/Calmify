//
//  ErrorManager.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 24/6/24.
//

import Foundation

enum ErrorManager: Error, LocalizedError {
    case noInternetConnection
    case notificationDenied
    case generalError(error: Error)
    case noInfoInSignIn
    case noInfoInSignUp
    case noEmailFoundForReset
    case notFindTopVC
    case deleteUser
    case emptyEmail
    case noUserWasFound
    case reauthenticationRequired
    
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "Please check your internet connection and try again."
        case .notificationDenied:
            return "Notification denied, if you want to receive notifications, you need to go to activate it in settings."
        case .generalError(error: let error):
            return "Error \(error.localizedDescription)"
        case .noInfoInSignIn:
            return "No info was written in sign in form"
        case .noInfoInSignUp:
            return "No info was written in sign up form"
        case .noEmailFoundForReset:
            return "The email was not found, please make sure you have an account with us"
        case .notFindTopVC:
            return "Did not find top viewcontroller"
        case .deleteUser:
            return "The user could not be deleted"
        case .emptyEmail:
            return "The email field is empty, please write a valid email"
        case .noUserWasFound:
            return "The user could not be authenticated"
        case .reauthenticationRequired:
            return "This operation is sensitive and requires recent authentication. Log in again before retrying this request."
        }
    }
}
