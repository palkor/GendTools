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
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController?.navigationBar.backgroundColor = UIColor.systemGreen
        self.navigationController?.navigationBar.barTintColor = UIColor.systemGreen
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ui_switch_search.isOn = UserDefaults.standard.bool(forKey: SettingViewController.OPTION_SEARCH_NATINF)
    }
    
    @IBAction func changeSwitchState(_ sender: UISwitch) {
        
        UserDefaults.standard.setValue(sender.isOn, forKey: SettingViewController.OPTION_SEARCH_NATINF)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
