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
    
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "Please check your internet connection and try again."
        case .notificationDenied:
            return "Notification denied, if you want to receive notifications, you need to go to activate it in settings."
        case .generalError(error: let error):
            return "Error \(error.localizedDescription)"
        }
    }
}
