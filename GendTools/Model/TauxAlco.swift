//
//  TauxAlco.swift
//  GendTools
//
//  Created by Pascal Ormancey on 06/02/2021.
//

import Foundation

class TauxAlco {
    var tauxAlcoolEthylo:Double = 0.0
    init(tauxAlcoolEthylo:Double) {
        self.tauxAlcoolEthylo = tauxAlcoolEthylo
    }
    
    var tauxRetenu:Double {
        var taux:Double = 0.0
       
        if tauxAlcoolEthylo >= 0.09 && tauxAlcoolEthylo <= 0.39 {
            
            taux = tauxAlcoolEthylo - 0.032
            
        } else if tauxAlcoolEthylo >= 0.4 && tauxAlcoolEthylo <= 2.0 {
             
            taux = tauxAlcoolEthylo - (tauxAlcoolEthylo * 8) / 100
            
        } else if tauxAlcoolEthylo > 2.0 {
            taux = tauxAlcoolEthylo - (tauxAlcoolEthylo * 30) / 100
        }
        else {
            taux = 0.0
        }

            return taux
    }
    


}
