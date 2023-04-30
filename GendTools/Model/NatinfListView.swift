import SwiftUI

/// Vue principale affichant la liste des infractions NATINF avec barre de recherche.
struct NatinfListView: View {
    @State private var searchText = ""
    let natinfs: [Natinf]

    var filteredNatinfs: [Natinf] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return natinfs
        } else {
            let text = searchText.lowercased()
            return natinfs.filter { $0.qualification.lowercased().folding(options: .diacriticInsensitive, locale: .current).contains(text.folding(options: .diacriticInsensitive, locale: .current)) || String($0.natinf).contains(text) }
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredNatinfs, id: \.natinf) { item in
                NavigationLink(destination: NatinfDetailView(natinf: item)) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(item.natinf) - \(item.qualificationPVe)")
                            .font(.headline)
                        Text(item.qualification)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .searchable(text: $searchText, prompt: Text("Recherche d'infraction"))
            .navigationTitle("Infractions NATINF")
        }
    }
}

/// Vue détaillée affichant toutes les propriétés d'une Natinf.
struct NatinfDetailView: View {
    let natinf: Natinf
    var body: some View {
        Form {
            Section(header: Text("Détail de l'infraction")) {
                LabeledContent("Qualification PVe", value: natinf.qualificationPVe)
                LabeledContent("Qualification", value: natinf.qualification)
                LabeledContent("NATINF", value: String(natinf.natinf))
                LabeledContent("Classe", value: String(natinf.classe))
                LabeledContent("Montant amende", value: "\(natinf.montant_amende) €")
                LabeledContent("Amende minorée", value: "\(natinf.montant_amende_minore) €")
                LabeledContent("Retrait de point", value: String(natinf.retrait_de_point))
                LabeledContent("Famille", value: natinf.famille)
                LabeledContent("Prévu par", value: natinf.infraction_prevu)
                LabeledContent("Réprimé par", value: natinf.infraction_reprime)
            }
        }
        .navigationTitle("NATINF \(natinf.natinf)")
    }
}

#Preview {
    NatinfListView(natinfs: [
        Natinf(
            qualificationPVe: "Conduite en état d'ivresse",
            qualification: "Conduite sous l'empire d'un état alcoolique.",
            natinf: 12345,
            classe: 4,
            montant_amende: 135,
            montant_amende_minore: 90,
            famille: "Alcool",
            retrait_de_point: 6,
            infraction_prevu: "Art. L234-1 Code de la route",
            infraction_reprime: "Art. L234-2 Code de la route"
        )
    ])
}
