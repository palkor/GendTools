//
//  Natinf.swift
//  DemoTableViewPlist
//
//  Created by Pascal Ormancey on 12/01/2021.
//  Copyright © 2021 Pascal Ormancey. All rights reserved.
//

import Foundation

class Natinf {
    var qualificationPVe: String
    var qualification:String
    var natinf: Int
    var classe: Int
    var montant_amende: Int
    var montant_amende_minore: String
    var famille: String
    var retrait_de_point: Int
    var infraction_prevu: String
    var infraction_reprime: String
   
    init(qualificationPVe: String, qualification:String, natinf:Int, classe:Int, montant_amende:Int, montant_amende_minore: String , famille:String, retrait_de_point:Int, infraction_prevu: String, infraction_reprime: String) {
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
