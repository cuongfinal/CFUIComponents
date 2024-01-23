//
//  NetworkManager.swift
//  B2Simulator
//
//  Created by Duong Tran Anh Thoai(ThoaiDTA) on 12/09/2022.
//

import Foundation
import Reachability

public class NetworkManager: NSObject {

    public var reachability: Reachability!
    
    public static let shared: NetworkManager = { return NetworkManager() }()
    
    
    private override init() {
        super.init()
        do {
            reachability = try Reachability()
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(networkStatusChanged(_:)),
                name: .reachabilityChanged,
                object: reachability
            )
            print("Network startNotifier")
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
        print("networkStatusChanged")
        
    }
    
    static func stopNotifier() -> Void {
        print("Network stopNotifier")
        (NetworkManager.shared.reachability).stopNotifier()
    }

    public func isReachable() -> Bool {
        print("Network isReachable")
        if (NetworkManager.shared.reachability).connection != .unavailable {
            return true
        }
        return false
    }
    
    public func isUnreachable() -> Bool {
        print("Network isUnreachable")
        if (NetworkManager.shared.reachability).connection == .unavailable {
            return true
        }
        return false
    }
    
    public func isReachableViaWWAN() -> Bool {
        print("Network isReachableViaWWAN")
        if (NetworkManager.shared.reachability).connection == .cellular {
            return true
        }
        return false
    }

    public func isReachableViaWiFi() -> Bool {
        print("Network isReachableViaWiFi")
        if (NetworkManager.shared.reachability).connection == .wifi {
            return true
        }
        return false
    }
}
