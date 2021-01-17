//
//  Natinf.swift
//  DemoTableViewPlist
//
//  Created by Pascal Ormancey on 12/01/2021.
//  Copyright © 2021 Pascal Ormancey. All rights reserved.
//

import Foundation

class Natinf {
    var qualification:String
    var natinf: Int
    var classe: Int
    var montant_amende: Int
    var montant_amende_minore: Int
    var famille: String
   
    init(qualification:String, natinf:Int, classe:Int, montant_amende:Int, montant_amende_minore: Int , famille:String) {
        self.qualification = qualification
        self.natinf = natinf
        self.classe = classe
        self.montant_amende = montant_amende
        self.montant_amende_minore = montant_amende_minore
        self.famille = famille
    }
}
