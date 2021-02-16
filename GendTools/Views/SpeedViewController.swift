//
//  SpeedViewController.swift
//  GendTools
//
//  Created by Pascal Ormancey on 09/01/2021.
//

import UIKit

class SpeedViewController: UIViewController, UITextFieldDelegate {
    
    let OPTION_SAVE_SPEED = "SPEED"
    
    var vitesseRetenue: Int = 0 // vitesse retenue
    var retraitDePoint:Int = 0 // nombre de point 
    var vitesseLimit:Int = 0 // limitation de la vitesse
    var index:Int = 0
    
    @IBOutlet weak var ui_segment_select_speed: UISegmentedControl!
    @IBOutlet weak var ui_textField_speed: UITextField!
    @IBOutlet weak var ui_label_Speed: UILabel!
    @IBOutlet weak var ui_label_points: UILabel!
    @IBOutlet weak var ui_label_vitesse: UILabel!
   
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.systemGreen
        self.navigationController?.navigationBar.barTintColor = UIColor.systemGreen
        
        vitesseLimit = UserDefaults.standard.integer(forKey: OPTION_SAVE_SPEED)
        switch vitesseLimit {
        case 30:
            index = 0
        case 50:
            index = 1
        case 70:
            index = 3
        case 80:
            index = 4
        case 90:
            index = 5
        case 110:
            index = 6
        case 130:
            index = 7
        default:
            index = 8
        }
        
        ui_segment_select_speed.selectedSegmentIndex = index
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    clearUi_label()
    }

    // MARK: - Selection de la limitation de vitesse
    
    @IBAction func actionChangeSegmentedControl(_ sender: UISegmentedControl) {
        
        switch ui_segment_select_speed.selectedSegmentIndex {
        case 0:
            vitesseLimit = 30
        case 1:
            vitesseLimit = 50
        case 2:
            vitesseLimit = 70
        case 3:
            vitesseLimit = 80
        case 4:
            vitesseLimit = 90
        case 5:
            vitesseLimit = 110
        case 6:
            vitesseLimit = 130
        default:
            vitesseLimit = 0
        }
        ui_label_vitesse.text = "Vitesse limitée à : \(vitesseLimit )"
        clearUi_label()
        UserDefaults.standard.setValue(vitesseLimit, forKey: OPTION_SAVE_SPEED)
        
    }
    
    
    // MARK: -  calcul de la vitesse retenue par rapport à la vitesse saisie
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        if let vitesse = ui_textField_speed.text {
        let speed = Speed(vitesseEnregistree: Int(vitesse) ?? 0, vitesseLimite: vitesseLimit)
            if speed.vitesseEnregistree != 0 {
                vitesseRetenue = speed.vitesseRetenue
                retraitDePoint = speed.retrait_Point
                computeSpeedAndPoint()
                
                } else {
                let alert = UIAlertController(title: "Erreur", message: "Veuillez entrer une valeur correcte.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertAction)
                present(alert, animated: true, completion: nil)
                }
                        
            }
        return true
        
        }
        
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let caractere = CharacterSet.decimalDigits
        let caractereInterdit = caractere.inverted
        let position = string.rangeOfCharacter(from: caractereInterdit)
        if position != nil {
            return false
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        ui_textField_speed.text = ""
        ui_textField_speed.resignFirstResponder()
        return false
    }
    
    // MARK: - calcul du nombre de point à retirer
    
    func computeSpeedAndPoint() {
        
        ui_label_Speed.text = "Vitesse retenue : \(String(vitesseRetenue))"
        ui_label_points.text = "Retrait de point : \(String(retraitDePoint))"
        ui_textField_speed.text = String("")
        ui_textField_speed.resignFirstResponder()
    }
    
    func clearUi_label() {
        ui_label_Speed.text = "Vitesse retenue : "
        ui_label_points.text = "Retrait de point : "
    }
    
  
}
