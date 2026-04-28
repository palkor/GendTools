//
//  EthyloViewController.swift
//  GendTools
//
//  Created by Pascal Ormancey on 09/01/2021.
//

import UIKit
import Foundation

class EthyloViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ui_textField_taux_affiche: UITextField!
    @IBOutlet weak var ui_label_taux_retenu: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = UIColor.systemGreen
        self.navigationController?.navigationBar.barTintColor = UIColor.systemGreen
        
        // Set adaptive text colors for dark mode support
        ui_label_taux_retenu.textColor = UIColor.label
        ui_textField_taux_affiche.textColor = UIColor.label
        
        ui_textField_taux_affiche.layer.cornerRadius = 8
        ui_textField_taux_affiche.layer.masksToBounds = true
        ui_textField_taux_affiche.layer.borderWidth = 1
        ui_textField_taux_affiche.layer.borderColor = UIColor.separator.cgColor
        
        // Accessibility labels
        ui_label_taux_retenu.accessibilityLabel = NSLocalizedString("taux retenu", comment: "accessibility label for taux retenu")
        ui_textField_taux_affiche.accessibilityLabel = NSLocalizedString("champ de saisie du taux d'alcool", comment: "accessibility label for alcohol rate input field")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ui_textField_taux_affiche.text = ""
        ui_label_taux_retenu.text = NSLocalizedString("Taux retenu :", comment: "label prefix for retained rate")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let taux_alcool = ui_textField_taux_affiche.text?.replacingOccurrences(of: ",", with: ".") {
            let alcool = TauxAlco.init(tauxAlcoolEthylo: Double(taux_alcool) ?? 0.0)
            let taux = alcool.tauxRetenu.reduceScale(to: 2)
            if taux != 0 {
                let currencyFormatter = NumberFormatter()
                currencyFormatter.numberStyle = .decimal
                currencyFormatter.locale = Locale.current
                ui_label_taux_retenu.text = String(format: NSLocalizedString("Taux retenu : %@", comment: "display retained rate value"), currencyFormatter.string(from: NSNumber(value: taux)) ?? "0")
                ui_textField_taux_affiche.resignFirstResponder()
            } else {
                let alertTitle = NSLocalizedString("Erreur", comment: "Alert title for error")
                let alertMessage = NSLocalizedString("Veuillez entrer une valeur décimale correcte.", comment: "Alert message for invalid decimal input")
                let alertOK = NSLocalizedString("OK", comment: "Alert OK button")
                
                let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: alertOK, style: .default, handler: nil)
                alert.addAction(alertAction)
                present(alert, animated: true, completion: nil)
            }
        }
        
        return true
    }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        ui_textField_taux_affiche.text = ""
        ui_textField_taux_affiche.resignFirstResponder()
        ui_label_taux_retenu.text = NSLocalizedString("Taux retenu :", comment: "label prefix for retained rate")
        return false
    }
    
  
}



// MARK: - Gestion de la suppression des chiffres après deux décimales.

/**
 Reduces the number of decimal places of a Double value by truncating extra digits.

 - Parameter places: The number of decimal places to keep.
 - Returns: A Double truncated to the specified number of decimal places.
 */
extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
    }
}

