//
//  ErrorManager.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 24/6/24.
//

import Foundation
import Firebase

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
    case noMusicWasFound
    
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
        case .noMusicWasFound:
            return "the music was not found in bundle"
        }
    }
}

/// Is used for firebase error handling
enum FirebaseAuthError: LocalizedError, Error {
    case invalidEmail
    case invalidCredential
    case wrongPassword
    case networkError
    case weakPassword
    case unknownError

    init(errorCode: Int) {
        switch AuthErrorCode.Code(rawValue: errorCode) {
        case .invalidEmail:
            self = .invalidEmail
        case .invalidCredential:
            self = .invalidCredential
        case .wrongPassword:
            self = .wrongPassword
        case .networkError:
            self = .networkError
        case .weakPassword:
            self = .weakPassword
        default:
            self = .unknownError
        }
    }

    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Invalid email, please ensure to add a correct email"
        case .invalidCredential:
            return "Wrong email or password, please check again"
        case .wrongPassword:
            return "Wrong password, please check again"
        case .networkError:
            return "No internet connection, please find internet connection"
        case .weakPassword:
            return "Weak password, please ensure to have a minimun of 6 characters"
        case .unknownError:
            return "Unknown error"
        }
    }
}
