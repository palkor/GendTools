import SwiftUI

/// Vue principale affichant la liste des infractions NATINF avec barre de recherche.
struct NatinfListView: View {
    @State private var searchText = ""
    @State private var natinfs: [Natinf] = []

    init() {
        _natinfs = State(initialValue: Self.loadNatinfsFromPlist())
    }

    /// Charge et décode les données NATINF à partir du fichier natinfdb.plist dans le bundle principal.
    /// - Returns: Un tableau de Natinf décodé ou un tableau vide en cas d'erreur.
    static func loadNatinfsFromPlist() -> [Natinf] {
        // Chercher l'URL du fichier natinfdb.plist dans le bundle principal
        guard let url = Bundle.main.url(forResource: "natinfdb", withExtension: "plist") else {
            print("Erreur: Le fichier natinfdb.plist est introuvable dans le bundle principal.")
            return []
        }
        do {
            // Charger les données brutes du fichier plist
            let data = try Data(contentsOf: url)
            // Créer un décodeur PropertyListDecoder
            let decoder = PropertyListDecoder()
            // Décoder les données en tableau de Natinf
            let decodedNatinfs = try decoder.decode([Natinf].self, from: data)
            return decodedNatinfs
        } catch {
            print("Erreur lors du décodage du fichier natinfdb.plist : \(error)")
            return []
        }
    }

    var filteredNatinfs: [Natinf] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return natinfs
        } else {
            let text = searchText.lowercased()
            return natinfs.filter { $0.qualification.lowercased().folding(options: .diacriticInsensitive, locale: .current).contains(text.folding(options: .diacriticInsensitive, locale: .current)) || String($0.natinf).contains(text) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Recherche d'infraction", text: $searchText)
                    .padding(.horizontal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                List(filteredNatinfs, id: \.natinf) { item in
                    NavigationLink(destination: NatinfDetailView(natinf: item)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(item.natinf) - \(item.qualificationPVe)")
                                .font(.headline)
                            Text(item.qualification)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationBarTitle("Infractions NATINF")
        }
    }
}

/// Vue détaillée affichant toutes les propriétés d'une Natinf.
struct NatinfDetailView: View {
    let natinf: Natinf
    var body: some View {
        Form {
            Section(header: Text("Détail de l'infraction")) {
                HStack {
                    Text("Qualification PVe")
                    Spacer()
                    Text(natinf.qualificationPVe)
                }
                HStack {
                    Text("Qualification")
                    Spacer()
                    Text(natinf.qualification)
                }
                HStack {
                    Text("NATINF")
                    Spacer()
                    Text(String(natinf.natinf))
                }
                HStack {
                    Text("Classe")
                    Spacer()
                    Text(String(natinf.classe))
                }
                HStack {
                    Text("Montant amende")
                    Spacer()
                    Text("\(natinf.montant_amende) €")
                }
                HStack {
                    Text("Amende minorée")
                    Spacer()
                    Text("\(natinf.montant_amende_minore) €")
                }
                HStack {
                    Text("Retrait de point")
                    Spacer()
                    Text(String(natinf.retrait_de_point))
                }
                HStack {
                    Text("Famille")
                    Spacer()
                    Text(natinf.famille)
                }
                HStack {
                    Text("Prévu par")
                    Spacer()
                    Text(natinf.infraction_prevu)
                }
                HStack {
                    Text("Réprimé par")
                    Spacer()
                    Text(natinf.infraction_reprime)
                }
            }
        }
        .navigationBarTitle("NATINF \(natinf.natinf)")
    }
}

#Preview {
    NavigationView {
        NatinfListView()
            .environment(\.locale, .init(identifier: "fr")) // For consistent preview localization if needed
            .onAppear {
                // Nothing needed, as NatinfListView loads from plist by default.
            }
    }
}
