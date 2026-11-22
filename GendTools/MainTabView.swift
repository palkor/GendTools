import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationView { SpeedCalculatorView() }
                .tabItem { Label("Vitesse", systemImage: "speedometer") }

            NavigationView { AlcoholCalculatorView() }
                .tabItem { Label("Éthylomètre", systemImage: "wineglass") }

            NavigationView { NatinfListView() }
                .tabItem { Label("NATINF", systemImage: "text.magnifyingglass") }

            NavigationView { SettingsView() }
                .tabItem { Label("Réglages", systemImage: "gearshape") }
        }
    }
}

private struct ScreenBackground: View {
    var body: some View {
        LinearGradient(
            colors: [Color.green.opacity(0.10), Color(.systemGroupedBackground)],
            startPoint: .topLeading,
            endPoint: .center
        )
        .ignoresSafeArea()
    }
}

private struct Card<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(Color.green.opacity(0.10), lineWidth: 1)
            }
    }
}

private struct ScreenHeading: View {
    let eyebrow: String
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(eyebrow.uppercased())
                .font(.caption.weight(.bold))
                .tracking(1.4)
                .foregroundColor(.green)
            Text(title)
                .font(.largeTitle.weight(.bold))
                .foregroundColor(.primary)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 12)
        .padding(.bottom, 6)
    }
}

private struct SpeedCalculatorView: View {
    private let speedLimits = [30, 50, 70, 80, 90, 110, 130]
    @AppStorage("SPEED") private var speedLimit = 50
    @StateObject private var state = SpeedCalculatorState()
    @FocusState private var isInputFocused: Bool

    var body: some View {
        ZStack {
            ScreenBackground()
            ScrollView {
                VStack(spacing: 18) {
                    ScreenHeading(eyebrow: "Outil de contrôle", title: "Calcul de vitesse", subtitle: "Estimez la vitesse retenue et le retrait de points.")

                    Card {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Vitesse limitée")
                                .font(.headline)
                            Picker("Vitesse limitée", selection: $speedLimit) {
                                ForEach(speedLimits, id: \.self) { limit in
                                    Text("\(limit)").tag(limit)
                                }
                            }
                            .pickerStyle(.segmented)
                            Text("Limitation sélectionnée : \(speedLimit) km/h")
                                .font(.subheadline.weight(.medium))
                                .foregroundColor(.secondary)
                        }
                    }

                    Card {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Vitesse enregistrée")
                                .font(.headline)
                            HStack(spacing: 12) {
                                TextField("Ex. 98", text: $state.enteredSpeed)
                                    .keyboardType(.numberPad)
                                    .focused($isInputFocused)
                                    .font(.title2.weight(.semibold))
                                    .padding(.leading, 14)
                                    .padding(.vertical, 14)
                                    .padding(.trailing, 42)
                                    .overlay(alignment: .trailing) {
                                        if !state.enteredSpeed.isEmpty {
                                            Button {
                                                withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                                    state.enteredSpeed = ""
                                                    state.result = nil
                                                }
                                            } label: {
                                                Image(systemName: "xmark.circle.fill")
                                                    .foregroundStyle(.secondary)
                                            }
                                            .buttonStyle(.plain)
                                            .padding(.trailing, 14)
                                            .accessibilityLabel("Effacer la saisie")
                                        }
                                    }
                                    .background(Color(.tertiarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
                                Text("km/h")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundColor(.secondary)
                            }
                            Button(action: calculate) {
                                Label("Calculer", systemImage: "equal.circle.fill")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 15)
                                    .foregroundColor(.white)
                                    .background(Color.green, in: RoundedRectangle(cornerRadius: 14))
                            }
                            .buttonStyle(.plain)
                        }
                    }

                    if let result = state.result {
                        Card {
                            VStack(alignment: .leading, spacing: 15) {
                                Label("Résultat", systemImage: "checkmark.seal.fill")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                HStack(alignment: .firstTextBaseline) {
                                    Text("\(result.retainedSpeed)")
                                        .font(.system(size: 42, weight: .bold, design: .rounded))
                                    Text("km/h retenus")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Divider()
                                HStack {
                                    Text("Retrait de points")
                                    Spacer()
                                    Text("\(result.points)")
                                        .font(.title3.weight(.bold))
                                        .foregroundColor(result.points == 0 ? .green : .orange)
                                }
                            }
                        }
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                    Spacer(minLength: 12)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("Vitesse")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Terminé") {
                    isInputFocused = false
                }
            }
        }
        .onChange(of: speedLimit) { _ in state.result = nil }
        .alert("Erreur", isPresented: $state.isShowingError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(state.errorMessage)
        }
    }

    private func calculate() {
        isInputFocused = false
        guard let recorded = Int(state.enteredSpeed), recorded > 0 else {
            state.errorMessage = "Saisissez une vitesse enregistrée valide."
            state.isShowingError = true
            return
        }
        let speed = Speed(vitesseEnregistree: recorded, vitesseLimite: speedLimit)
        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
            state.result = SpeedResult(retainedSpeed: speed.vitesseRetenue, points: speed.retrait_Point)
        }
    }
}

private struct SpeedResult {
    let retainedSpeed: Int
    let points: Int
}

private final class SpeedCalculatorState: ObservableObject {
    @Published var enteredSpeed = ""
    @Published var result: SpeedResult?
    @Published var errorMessage = ""
    @Published var isShowingError = false
}

private struct AlcoholCalculatorView: View {
    @StateObject private var state = AlcoholCalculatorState()
    @FocusState private var isInputFocused: Bool

    var body: some View {
        ZStack {
            ScreenBackground()
            ScrollView {
                VStack(spacing: 18) {
                    ScreenHeading(eyebrow: "Outil de contrôle", title: "Éthylomètre", subtitle: "Calculez le taux retenu à partir de la valeur affichée.")

                    Card {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Taux affiché")
                                .font(.headline)
                            HStack(spacing: 12) {
                                TextField("Ex. 0,25", text: $state.displayedRate)
                                    .keyboardType(.decimalPad)
                                    .focused($isInputFocused)
                                    .font(.title2.weight(.semibold))
                                    .padding(.leading, 14)
                                    .padding(.vertical, 14)
                                    .padding(.trailing, 42)
                                    .overlay(alignment: .trailing) {
                                        if !state.displayedRate.isEmpty {
                                            Button {
                                                withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                                    state.displayedRate = ""
                                                    state.retainedRate = nil
                                                }
                                            } label: {
                                                Image(systemName: "xmark.circle.fill")
                                                    .foregroundStyle(.secondary)
                                            }
                                            .buttonStyle(.plain)
                                            .padding(.trailing, 14)
                                            .accessibilityLabel("Effacer la saisie")
                                        }
                                    }
                                    .background(Color(.tertiarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
                                Text("mg/L")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundColor(.secondary)
                            }
                            Button(action: calculate) {
                                Label("Calculer le taux retenu", systemImage: "equal.circle.fill")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 15)
                                    .foregroundColor(.white)
                                    .background(Color.green, in: RoundedRectangle(cornerRadius: 14))
                            }
                            .buttonStyle(.plain)
                        }
                    }

                    if let retainedRate = state.retainedRate {
                        Card {
                            VStack(alignment: .leading, spacing: 12) {
                                Label("Taux retenu", systemImage: "checkmark.seal.fill")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                HStack(alignment: .firstTextBaseline, spacing: 7) {
                                    Text(retainedRate)
                                        .font(.system(size: 42, weight: .bold, design: .rounded))
                                    Text("mg/L")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                    Spacer(minLength: 12)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("Éthylomètre")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Terminé") {
                    isInputFocused = false
                }
            }
        }
        .alert("Erreur", isPresented: $state.isShowingError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(state.errorMessage)
        }
    }

    private func calculate() {
        isInputFocused = false
        let normalized = state.displayedRate.replacingOccurrences(of: ",", with: ".")
        guard let value = Double(normalized), value > 0 else {
            state.errorMessage = "Saisissez un taux décimal valide, par exemple 0,25."
            state.isShowingError = true
            return
        }
        let result = TauxAlco(tauxAlcoolEthylo: value).tauxRetenu
        guard result > 0 else {
            state.errorMessage = "Le taux affiché est trop faible pour calculer un taux retenu."
            state.isShowingError = true
            return
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
            state.retainedRate = formatter.string(from: NSNumber(value: result)) ?? String(format: "%.2f", result)
        }
    }
}

private final class AlcoholCalculatorState: ObservableObject {
    @Published var displayedRate = ""
    @Published var retainedRate: String?
    @Published var errorMessage = ""
    @Published var isShowingError = false
}

private struct NatinfListView: View {
    @AppStorage("OPTION") private var searchByNatinf = false
    @StateObject private var state = NatinfSearchState()
    private let natinfs = NatinfStore.load()

    private var filteredNatinfs: [Natinf] {
        guard !state.searchText.isEmpty else { return natinfs }
        if searchByNatinf {
            return natinfs.filter { String($0.natinf).contains(state.searchText) }
        }
        return natinfs.filter { $0.qualification.localizedCaseInsensitiveContains(state.searchText) }
    }

    var body: some View {
        List {
            Section {
                ForEach(filteredNatinfs) { natinf in
                    NavigationLink(destination: NatinfDetailView(natinf: natinf)) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("NATINF \(natinf.natinf)")
                                .font(.caption.weight(.bold))
                                .foregroundColor(.green)
                            Text(natinf.qualificationPVe)
                                .font(.body.weight(.medium))
                                .foregroundColor(.primary)
                                .lineLimit(3)
                        }
                        .padding(.vertical, 5)
                    }
                }
            } header: {
                Text("\(filteredNatinfs.count) infraction\(filteredNatinfs.count == 1 ? "" : "s")")
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Infractions")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $state.searchText, prompt: searchByNatinf ? "Rechercher un numéro NATINF" : "Rechercher une infraction")
        .overlay {
            if filteredNatinfs.isEmpty {
                ContentUnavailableViewCompat(searchText: state.searchText)
            }
        }
    }
}

private final class NatinfSearchState: ObservableObject {
    @Published var searchText = ""
}

private struct ContentUnavailableViewCompat: View {
    let searchText: String

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            Text(searchText.isEmpty ? "Aucune donnée disponible" : "Aucun résultat")
                .font(.headline)
            if !searchText.isEmpty {
                Text("Essayez un autre terme de recherche.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .allowsHitTesting(false)
    }
}

private struct NatinfDetailView: View {
    let natinf: Natinf

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    Text("NATINF \(natinf.natinf)")
                        .font(.caption.weight(.bold))
                        .foregroundColor(.green)
                    Text(natinf.qualification)
                        .font(.title3.weight(.bold))
                }
                .padding(.vertical, 6)
            }
            Section("Sanctions") {
                detailRow("Classe", "\(natinf.classe)")
                detailRow("Amende forfaitaire", euro(natinf.montant_amende))
                detailRow("Amende minorée", euro(natinf.montant_amende_minore))
                detailRow("Retrait de points", "\(natinf.retrait_de_point)")
            }
            Section("Qualification") {
                detailRow("Famille", natinf.famille)
                detailRow("Prévu par", natinf.infraction_prevu)
                detailRow("Réprimé par", natinf.infraction_reprime)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Détail NATINF")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func detailRow(_ title: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title).font(.caption).foregroundColor(.secondary)
            Text(value.isEmpty ? "Non renseigné" : value)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, 3)
    }

    private func euro(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter.string(from: NSNumber(value: value)) ?? "\(value) €"
    }
}

private struct SettingsView: View {
    @AppStorage("OPTION") private var searchByNatinf = false
    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Non disponible"
    }

    var body: some View {
        ZStack {
            ScreenBackground()
            ScrollView {
                VStack(spacing: 18) {
                    ScreenHeading(eyebrow: "Personnalisation", title: "Réglages", subtitle: "Adaptez la recherche à votre usage.")
                    Card {
                        Toggle(isOn: $searchByNatinf) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Recherche par numéro")
                                    .font(.headline)
                                Text("Dans l’onglet NATINF, rechercher par code plutôt que par qualification.")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .tint(.green)
                    }
                    Card {
                        HStack(spacing: 14) {
                            Image(systemName: "checkmark.shield.fill")
                                .font(.title2)
                                .foregroundColor(.green)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("GendTools")
                                    .font(.headline)
                                Text("Version \(appVersion)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                    }
                    Spacer(minLength: 12)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("Réglages")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private enum NatinfStore {
    static func load() -> [Natinf] {
        guard let url = Bundle.main.url(forResource: "natinfdb", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let rows = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String: Any]] else {
            return []
        }
        return rows.compactMap(Natinf.init(dictionary:))
    }
}

#Preview {
    MainTabView()
}
