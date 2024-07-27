//
//  Secondhand_MarketApp.swift
//  Secondhand_Market
//
//  Created by Minseok Chey on 7/21/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore


@main
struct Secondhand_MarketApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var userViewModel = UserViewModel()
    @State private var isUserLoggedIn: Bool = false
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoginView(isUserLoggedIn: $isUserLoggedIn).environmentObject(userViewModel)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Configured Firebase!")
        return true
    }
}


