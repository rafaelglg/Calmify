//
//  CalmifyApp.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 5/6/24.
//

import SwiftUI
import FirebaseCore

@main
struct CalmifyApp: App {
    @State private var networkMonitor = NetworkManager.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .environment(networkMonitor)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
