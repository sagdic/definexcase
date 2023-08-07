//
//  SecondViewViewModel.swift
//  definexcase
//
//  Created by Digiturk on 22.01.2023.
//

import Foundation
import FirebaseRemoteConfig

class SecondViewViewModel: NSObject, ObservableObject {
    
    @Published var rcString = "tayfunSagdic"
    let rc = RemoteConfig.remoteConfig()
    let settings = RemoteConfigSettings()
    
    override init() {
        super.init()
        Task {
            try await startFetching()
        }
    }
    
    private func startFetching() async throws {
        
        settings.minimumFetchInterval = 0
        rc.configSettings = settings
        
        do {
            let config = try await rc.fetchAndActivate()
            switch config {
            case .successFetchedFromRemote:
                self.rcString = rc.configValue(forKey: "rcValue").stringValue ?? "defvalue"
                return
            case .successUsingPreFetchedData:
                self.rcString = rc.configValue(forKey: "rcValue").stringValue ?? "defvalue"
                return
            default:
                print("Error activating")
                return
            }
        } catch let error {
            print("Error fetching: \(error.localizedDescription)")
        }
    }
}

