//
//  NetworkManager.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 16/7/24.
//

import Foundation
import Network

protocol NetworkManagerProtocol {
    func getConnection()
}

@Observable
final class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    let networkMonitor = NWPathMonitor()
    let workingQueue = DispatchQueue(label: "Monitor")
    var isConnected: Bool = false
    
    private init() {
        getConnection()
        networkMonitor.start(queue: workingQueue)
    }
    
    func getConnection() {
        networkMonitor.pathUpdateHandler = { path in
            Task {
                await MainActor.run {
                    self.isConnected = path.status == .satisfied
                }
            }
        }
    }
}

/*
 Wifi icon + text:
 
 Image(systemName: network.isConnected ? "wifi" : "wifi.slash")
 .font(.title)
 .foregroundStyle(network.isConnected ? .green : .red)
 
 Text(network.isConnected ? "Connected" : "Disconnected")
 .font(.title)
 .fontWeight(.bold)
 .foregroundStyle(network.isConnected ? .green : .red)
 }
 */
