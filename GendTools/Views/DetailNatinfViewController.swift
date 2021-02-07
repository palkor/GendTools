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
    @IBOutlet weak var ui_label_retrait_point: UILabel!
    @IBOutlet weak var ui_label_famille: UILabel!
    @IBOutlet weak var ui_label_prevu: UILabel!
    @IBOutlet weak var ui_label_reprime: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui_label_qualification.text = "Détail de l'infraction : \(natinfNatinf?.qualification.lowercased() ?? "-")"
        ui_label_natinf.text = "NATINF : \(String(natinfNatinf?.natinf ?? 0))"
        ui_label_classe.text = "Classe : \(String(natinfNatinf?.classe ?? 0))"
        ui_label_montant_amende.text = "Montant de l'amende : \(Int(natinfNatinf?.montant_amende ?? 0) ) €"
        ui_label_montant_amende_minoree.text = "Montant de l'amende minorée : \(Int(natinfNatinf?.montant_amende_minore ?? 0)) €"
        ui_label_famille.text = "Famille : \(natinfNatinf?.famille ?? "-")"
        ui_label_retrait_point.text = "Retraite de point : \(natinfNatinf?.retrait_de_point ?? 0)"
        ui_label_prevu.text = "Infraction prévue par : \(natinfNatinf?.infraction_prevu ?? "")"
        ui_label_reprime.text = "Infraction réprimée par : \(natinfNatinf?.infraction_reprime ?? "")"
    
    }
    
}
