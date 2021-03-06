//
//  FindPlayerApp.swift
//  Shared
//
//  Created by Emmanuel Tesauro on 22/08/2020.
//

import SwiftUI
import Firebase
import FirebaseCore

@main
struct FindPlayerApp: App {
    
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

//Connecting to Firebase
class Delegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {


        FirebaseApp.configure()
        return true
    }
}
