//
//  SpeedViewController.swift
//  GendTools
//
//  Created by Pascal Ormancey on 09/01/2021.
//

import UIKit

class SpeedViewController: UIViewController, UITextFieldDelegate {

    var vitesseRetenue: Int = 30
    var retraitDePoint:Int = 0
    var vitesseLimit:Int = 0
    
    @IBOutlet weak var ui_segment_select_speed: UISegmentedControl!
    @IBOutlet weak var ui_textField_speed: UITextField!
    @IBOutlet weak var ui_label_Speed: UILabel!
    @IBOutlet weak var ui_label_points: UILabel!
    @IBOutlet weak var ui_label_vitesse: UILabel!
   
    override func viewDidLoad() {
    
    }
    
    
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
        ui_label_vitesse.text = "Vitesse limitée à : \(vitesseLimit)"
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let vitesse = ui_textField_speed.text {
            let speed = Speed(vitesseEnregistree: Int(vitesse) ?? 0, vitesseLimite: vitesseLimit)
        vitesseRetenue = speed.vitesseRetenue
            retraitDePoint = speed.retrait_Point
        computeSpeedAndPoint()
        }
        return false
        
    }
    
    func computeSpeedAndPoint() {
        
        ui_label_Speed.text = "Vitesse retenue : \(String(vitesseRetenue))"
        ui_label_points.text = "Retrait de point : \(String(retraitDePoint))"
        ui_textField_speed.text = String("")
        ui_textField_speed.resignFirstResponder()
    }
  
}
