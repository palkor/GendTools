//
//  SceneDelegate.swift
//  GendTools
//
//  Created by Pascal Ormancey on 09/01/2021.
//

import UIKit

/// Manages the lifecycle and UI-related behavior of a single app scene.
/// Responsible for configuring and maintaining the window and responding to scene lifecycle events.
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    /// Called when the scene is connecting to the app session.
    /// Use this method to configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    /// - Parameters:
    ///   - scene: The scene being connected.
    ///   - session: The session associated with the scene.
    ///   - connectionOptions: Additional options for connecting the scene.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Ensure the scene is a UIWindowScene before continuing.
        guard let _ = (scene as? UIWindowScene) else { return }
        // UIWindow and rootViewController setup is usually done via storyboard or elsewhere.
    }

    /// Called when the scene is disconnected and released by the system.
    /// Release any resources tied to this scene here.
    /// - Parameter scene: The scene being disconnected.
    func sceneDidDisconnect(_ scene: UIScene) {
        // Scene has been released by the system.
        // Clean up any resources specific to this scene.
    }

    /// Called when the scene moves from an inactive to an active state.
    /// Restart any tasks that were paused or not yet started while inactive.
    /// - Parameter scene: The scene that became active.
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Restart tasks paused (or not started) while the scene was inactive.
    }

    /// Called when the scene moves from an active to an inactive state.
    /// This can occur due to temporary interruptions (e.g., incoming phone call).
    /// - Parameter scene: The scene that will resign active.
    func sceneWillResignActive(_ scene: UIScene) {
        // Pause ongoing tasks or disable functionality as the scene moves to inactive state.
    }

    /// Called as the scene transitions from background to foreground.
    /// Undo changes made on entering the background here.
    /// - Parameter scene: The scene entering the foreground.
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Prepare the UI or state before the scene becomes active.
    }

    /// Called as the scene transitions from foreground to background.
    /// Save data, release shared resources, and store enough state information
    /// to restore the scene back to its current state.
    /// - Parameter scene: The scene entering the background.
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Save data and release resources appropriate for background state.
    }
}

