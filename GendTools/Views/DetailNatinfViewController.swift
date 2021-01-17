//
//  DetailNatinfViewController.swift
//  GendTools
//
//  Created by Pascal Ormancey on 09/01/2021.
//

import UIKit

class DetailNatinfViewController: UIViewController {
    
    var natinfSelected = [String:Any]()
    var natinfNatinf: Natinf?
    
    @IBOutlet weak var ui_label_qualification: UILabel!
    @IBOutlet weak var ui_label_natinf: UILabel!
    @IBOutlet weak var ui_label_classe: UILabel!
    @IBOutlet weak var ui_label_montant_amende: UILabel!
    @IBOutlet weak var ui_label_montant_amende_minoree: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui_label_qualification.text = natinfNatinf?.qualification
        ui_label_natinf.text = String(natinfNatinf!.natinf)
        ui_label_classe.text = String(natinfNatinf!.classe)
        ui_label_montant_amende.text = String(natinfNatinf!.montant_amende)
        ui_label_montant_amende_minoree.text = natinfNatinf?.montant_amende_minore
      
    }
    
}
