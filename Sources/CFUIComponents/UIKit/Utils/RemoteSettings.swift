//
//  File.swift
//  
//
//  Created by Cuong Le on 9/15/22.
//

import Foundation
import FirebaseRemoteConfig

public typealias CompletedResult = (_ success: Bool, _ error: NSError?) -> Void

internal enum ValueKey: String {
    case updateConfig = "update_config"
    case videoUrl = "video_url"
    case haveComingSoon = "have_coming_soon"
}

public class RemoteSettings {
    public static let instance = RemoteSettings()
    
    private init() {
//        loadDefaultValues()
    }
    
    func loadDefaultValues() {
//        let appDefaults: [String: Any?] = [:]
//        RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
    }
      
    public func fetchCloudValues(completed: @escaping CompletedResult) {
        let fetchDuration: TimeInterval = 60
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: fetchDuration) { _, error in
            if let error = error {
                print("Uh-oh. Got an error fetching remote values \(error)")
                completed(false, error as NSError)
                return
            }
            
            RemoteConfig.remoteConfig().activate(completion: nil)
            print("Retrieved values from the cloud!")
            completed(true, nil)
        }
    }
    
    func getBool(forKey key: ValueKey) -> Bool {
      return RemoteConfig.remoteConfig()[key.rawValue].boolValue
    }

    func getString(forKey key: ValueKey) -> String {
      return RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
    }

    func getDouble(forKey key: ValueKey) -> Double {
        return RemoteConfig.remoteConfig()[key.rawValue].numberValue.doubleValue
    }
    
    func getInt(forKey key: ValueKey) -> Int {
        return RemoteConfig.remoteConfig()[key.rawValue].numberValue.intValue
    }
    
    func getObject(forKey key: ValueKey) -> Any? {
        let objectValue = RemoteConfig.remoteConfig()[key.rawValue].dataValue
        return try? JSONSerialization.jsonObject(with: objectValue, options: .allowFragments)
    }
    
    func getObjectData(forKey key: ValueKey) -> Data? {
        return RemoteConfig.remoteConfig()[key.rawValue].dataValue
    }
}

//Config
public extension RemoteSettings {
    func updateConfig() -> Data? {
        return getObjectData(forKey: ValueKey.updateConfig)
    }
    
    func videoURL() -> String {
        let url = getString(forKey: ValueKey.videoUrl)
        return url.isEmpty ? "https://amycosmetics.online/mophong/" : url
    }
    
    func haveComingSoon() -> Bool {
        return getBool(forKey: ValueKey.haveComingSoon)
    }
}
