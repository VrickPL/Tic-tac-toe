//
//  ConnectionManager.swift
//  Tic tac toe
//
//  Created by Jan Kazubski on 12/03/2024.
//

import Foundation
import Network

class ConnectionManager: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue (label: "Monitor")
    @Published var isActive = false
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isActive = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
