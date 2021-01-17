//
//  DetailNatinfViewController.swift
//  GendTools
//
//  Created by Pascal Ormancey on 09/01/2021.
//

import UIKit

class DetailNatinfViewController: UIViewController {
    
    var natinfSelected = [String:Any]()
    
    @IBOutlet weak var ui_label_qualification: UILabel!
    @IBOutlet weak var ui_label_natinf: UILabel!
    @IBOutlet weak var ui_label_classe: UILabel!
    @IBOutlet weak var ui_label_montant_amende: UILabel!
    @IBOutlet weak var ui_label_montant_amende_minoree: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
        
        if (Int(natinfSelected["Montant_minore"] as?Int ?? 0) != 0) {
            ui_label_montant_amende_minoree.text = "Montant de l'amende minorée : " + String(natinfSelected ["Montant_minore"] as! Int)
            
        }
        
        // Do ay additional setup after loading the view.
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
