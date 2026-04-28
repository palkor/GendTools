//
//  TauxAlco.swift
//  GendTools
//
//  Created by Pascal Ormancey on 06/02/2021.
//

import Foundation

/// Calculateur de taux d'alcool retenu à partir du taux d'alcool éthylique mesuré.
/// Cette structure calcule un taux ajusté selon des règles définies.
struct TauxAlco: Codable {
    /// Taux d'alcool éthylique mesuré (en g/L).
    var tauxAlcoolEthylo: Double
    
    /// Initialise un `TauxAlco` avec un taux d'alcool éthylique donné.
    /// - Parameter tauxAlcoolEthylo: Le taux d'alcool éthylique mesuré.
    init(tauxAlcoolEthylo: Double) {
        self.tauxAlcoolEthylo = tauxAlcoolEthylo
    }
    
    /// Taux d'alcool retenu après application des règles de calcul spécifiques.
    var tauxRetenu: Double {
        switch tauxAlcoolEthylo {
        case 0.09...0.39:
            return tauxAlcoolEthylo - 0.032
        case 0.40...2.0:
            return tauxAlcoolEthylo * 0.92  // équivaut à tauxAlcoolEthylo - 8%
        case let x where x > 2.0:
            return tauxAlcoolEthylo * 0.70  // équivaut à tauxAlcoolEthylo - 30%
        default:
            return 0.0
        }
    }
}

