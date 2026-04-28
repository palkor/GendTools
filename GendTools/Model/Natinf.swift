//
//  Natinf.swift
//  DemoTableViewPlist
//
//  Created by Pascal Ormancey on 12/01/2021.
//  Copyright © 2021 Pascal Ormancey. All rights reserved.
//

import Foundation

/// Modélise une infraction routière avec ses caractéristiques et sanctions associées.
struct Natinf: Codable {
    /// Qualification PVe de l'infraction.
    let qualificationPVe: String
    /// Qualification textuelle de l'infraction.
    let qualification: String
    /// Identifiant numérique de l'infraction.
    let natinf: Int
    /// Classe de l'infraction.
    let classe: Int
    /// Montant de l'amende associée.
    let montant_amende: Int
    /// Montant minoré de l'amende.
    let montant_amende_minore: Int
    /// Famille d'infraction.
    let famille: String
    /// Nombre de points retirés.
    let retrait_de_point: Int
    /// Texte décrivant l'infraction prévue.
    let infraction_prevu: String
    /// Texte décrivant l'infraction réprimée.
    let infraction_reprime: String
    
    init(
        qualificationPVe: String,
        qualification: String,
        natinf: Int,
        classe: Int,
        montant_amende: Int,
        montant_amende_minore: Int,
        famille: String,
        retrait_de_point: Int,
        infraction_prevu: String,
        infraction_reprime: String
    ) {
        self.qualificationPVe = qualificationPVe
        self.qualification = qualification
        self.natinf = natinf
        self.classe = classe
        self.montant_amende = montant_amende
        self.montant_amende_minore = montant_amende_minore
        self.famille = famille
        self.retrait_de_point = retrait_de_point
        self.infraction_prevu = infraction_prevu
        self.infraction_reprime = infraction_reprime
    }
}
