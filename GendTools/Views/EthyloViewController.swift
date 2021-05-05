//
//  EthyloViewController.swift
//  GendTools
//
//  Created by Pascal Ormancey on 09/01/2021.
//

import UIKit

class EthyloViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ui_textField_taux_affiche: UITextField!
    @IBOutlet weak var ui_label_taux_retenu: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = UIColor.systemGreen
        self.navigationController?.navigationBar.barTintColor = UIColor.systemGreen
     
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ui_textField_taux_affiche.text = ""
        ui_label_taux_retenu.text = "Taux retenu :"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let taux_alcool = ui_textField_taux_affiche.text {
            let alcool = TauxAlco.init(tauxAlcoolEthylo: Double(taux_alcool) ?? 0.0)
            let taux = alcool.tauxRetenu.reduceScale(to: 2)
            if taux != 0 {
           //     ui_label_taux_retenu.text = "Taux retenu : \(taux) mg/litre."
                let currencyFormatter = NumberFormatter()
                currencyFormatter.numberStyle = .decimal
                currencyFormatter.locale = Locale.current
                ui_label_taux_retenu.text = currencyFormatter.string(from: NSNumber(value: taux))
                ui_textField_taux_affiche.resignFirstResponder()
            } else {
                let alert = UIAlertController(title: "Erreur", message: "Veuillez entrer une valeur correcte. Utilisez le . pour la valeur décimale", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertAction)
                present(alert, animated: true, completion: nil)
            }
                
            
           
            
        }
        
        return true
    }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        ui_textField_taux_affiche.text = ""
        ui_textField_taux_affiche.resignFirstResponder()
        return false
    }
    
  
}



// MARK: - Gestion de la suppression des chiffres arprès deux décimales.

extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
    }
}

// MARK: - Formatage




