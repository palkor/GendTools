//
//  MainTabBarControllerViewController.swift
//  GendTools
//
//  Created by Pascal Ormancey on 09/01/2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // MARK: - Paramétrage de la Tab bar  - couleur des icones désélectionnées et du texte.
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemGreen], for: .selected)
        tabBar.unselectedItemTintColor = UIColor.systemGray2
            
       
    }
    

}
