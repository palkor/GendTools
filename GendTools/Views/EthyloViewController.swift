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
        
        let alcool = TauxAlco.init(tauxAlcoolEthylo: 0.45)
        let taux = alcool.tauxRetenu
        print(taux)
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let taux_alcool = ui_textField_taux_affiche.text {
            let alcool = TauxAlco.init(tauxAlcoolEthylo: Double(taux_alcool) ?? 0.0)
            let taux = alcool.tauxRetenu.reduceScale(to: 2)
            ui_label_taux_retenu.text = "Taux retenue : \(taux) mg/litre."
            
           
        }
        
        return true
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



extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
    }
}
