//
//  PixelArtApp.swift
//  PixelArt
//
//  Created by Hüseyin Gündoğdu on 04/02/2025.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
        FirebaseApp.configure()
        
        let settings = FirestoreSettings()
        settings.cacheSettings = MemoryCacheSettings(
            garbageCollectorSettings: MemoryLRUGCSettings()
        )
        
        Firestore.firestore().settings = settings
        
        return true
    }
}

@main
struct PixelArtApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
