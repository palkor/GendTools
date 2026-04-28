//
//  SettingViewController.swift
//  GendTools
//
//  Created by Pascal Ormancey on 09/01/2021.
//

import UIKit

class SettingViewController: UIViewController {
    
    static let OPTION_SEARCH_NATINF = "OPTION"
    
    @IBOutlet weak var ui_switch_search: UISwitch!
    
    @IBOutlet weak var ui_label_versionApp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Use systemBackground and label colors to support dark mode
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemGreen
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let appVersion = Bundle.main.appVersion
        let versionText = String(format: NSLocalizedString("Application GendTools version : %@", comment: "App version label with version number"), appVersion ?? NSLocalizedString("non disponible", comment: "Version not available"))
        ui_label_versionApp.text = versionText
        
        // Accessibility labels for UI elements
        ui_switch_search.accessibilityLabel = NSLocalizedString("Option de recherche natinf", comment: "Accessibility label for search option switch")
        ui_label_versionApp.accessibilityLabel = NSLocalizedString("Version de l'application GendTools", comment: "Accessibility label for app version label")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Restore switch state from user defaults
        ui_switch_search.isOn = UserDefaults.standard.bool(forKey: SettingViewController.OPTION_SEARCH_NATINF)
    }
    
    @IBAction func changeSwitchState(_ sender: UISwitch) {
        // Save the new switch state to user defaults
        UserDefaults.standard.setValue(sender.isOn, forKey: SettingViewController.OPTION_SEARCH_NATINF)
    }
    
}

/// Extension to provide easy access to the app's version string from the Info.plist
extension Bundle {
    /// Returns the app's short version string (CFBundleShortVersionString) if available.
    var appVersion: String? {
        self.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    /// Returns the main bundle's app version string.
    static var mainAppVersion: String? {
        Bundle.main.appVersion
    }
}
