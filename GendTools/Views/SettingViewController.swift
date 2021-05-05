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
       
        self.navigationController?.navigationBar.backgroundColor = UIColor.systemGreen
        self.navigationController?.navigationBar.barTintColor = UIColor.systemGreen
        
        let appVersion = Bundle.main.appVersion
        ui_label_versionApp.text = "Application GendTools version : \(appVersion ?? "non disponible")"
        // Do any additional setup after loading the view/remove fil
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ui_switch_search.isOn = UserDefaults.standard.bool(forKey: SettingViewController.OPTION_SEARCH_NATINF)
    }
    
    @IBAction func changeSwitchState(_ sender: UISwitch) {
        
        UserDefaults.standard.setValue(sender.isOn, forKey: SettingViewController.OPTION_SEARCH_NATINF)
    }
    
    
}

extension Bundle {
    var appVersion: String? {
        self.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    static var mainAppVersion: String? {
        Bundle.main.appVersion
    }
}
