import Foundation

struct Natinf: Identifiable {
    let qualificationPVe: String
    let qualification: String
    let natinf: Int
    let classe: Int
    let montant_amende: Int
    let montant_amende_minore: Int
    let famille: String
    let retrait_de_point: Int
    let infraction_prevu: String
    let infraction_reprime: String

    var id: Int { natinf }

    init?(dictionary: [String: Any]) {
        guard let natinf = Self.integer(dictionary["Natinf"]),
              let qualification = dictionary["Qualification"] as? String,
              let qualificationPVe = dictionary["QualificationPVe"] as? String else {
            return nil
        }

        self.natinf = natinf
        self.qualification = qualification
        self.qualificationPVe = qualificationPVe
        self.classe = Self.integer(dictionary["Classe"]) ?? 0
        self.montant_amende = Self.integer(dictionary["Montant_amende"]) ?? 0
        self.montant_amende_minore = Self.integer(dictionary["Montant_minore"]) ?? 0
        self.famille = dictionary["Famille"] as? String ?? ""
        self.retrait_de_point = Self.integer(dictionary["Retrait_points"]) ?? 0
        self.infraction_prevu = dictionary["Prevu"] as? String ?? ""
        self.infraction_reprime = dictionary["Reprime"] as? String ?? ""
    }

    private static func integer(_ value: Any?) -> Int? {
        if let number = value as? NSNumber { return number.intValue }
        if let string = value as? String { return Int(string) }
        return nil
    }
}
