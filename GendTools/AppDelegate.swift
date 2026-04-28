//
//  AppDelegate.swift
//  GendTools
//
//  Created by Pascal Ormancey on 09/01/2021.
//

import UIKit

/// The app delegate is the central point of control and coordination for apps running in iOS.
/// It responds to app-level events such as launch, scene session lifecycle management, and more.
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// Called when the app has completed its launch process.
    /// - Parameters:
    ///   - application: The singleton app object.
    ///   - launchOptions: A dictionary indicating the reason the app was launched (if any).
    /// - Returns: `true` if the app launch was successful; otherwise, `false`.
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Perform any final initialization after app launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    /// Called when a new scene session is being created.
    /// Use this method to select a configuration to create the new scene with.
    /// - Parameters:
    ///   - application: The singleton app object.
    ///   - connectingSceneSession: The scene session being created.
    ///   - options: Additional options used to configure the scene.
    /// - Returns: A UISceneConfiguration object describing the configuration for the new scene.
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    /// Called when the user discards a scene session.
    /// If any sessions were discarded while the app was not running, this will be called shortly after application launch.
    /// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    /// - Parameters:
    ///   - application: The singleton app object.
    ///   - sceneSessions: The set of discarded scene sessions.
    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Resources specific to discarded scenes can be released here.
    }
}

