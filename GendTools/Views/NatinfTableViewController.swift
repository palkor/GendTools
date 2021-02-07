//
//  NatinfTableViewController.swift
//  GendTools
//
//  Created by Pascal Ormancey on 09/01/2021.
//

import UIKit

class NatinfTableViewController: UITableViewController, UISearchResultsUpdating {
    static let COLOR_NAV:UIColor = UIColor(named: "Green")!
        
    var _natinfItems = [[String:Any]]() // Tableau de dictionnaires du fichier PLIST
    var _natinfsArray = [Natinf]()  // tableau avec objets NATINF
    var _filteredsNatinfArray = [Natinf]() // tableau résultats searchBar
    var selectedNatinf:Natinf?
    let searchController = UISearchController(searchResultsController: nil) // barre de recherche
    var state:Bool = false // variable état bouton recherche texte/natinf
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
    // MARK: - Paramétrage aspect du navigation controller
        self.navigationController?.navigationBar.backgroundColor = UIColor.systemGreen
        self.navigationController?.navigationBar.barTintColor = UIColor.systemGreen
        
        
    // MARK: - Paramètrage de la barre de recherche
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Recherche d'infraction"
        searchController.searchBar.barTintColor = UIColor.systemGreen
        searchController.searchBar.backgroundColor = UIColor.systemGreen
        searchController.searchBar.searchTextField.backgroundColor = UIColor.systemBackground
        navigationItem.searchController = searchController
      

        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // MARK: - Récupération du fichier natinfdb.plist
        
        if let natinfdbPlistPath = Bundle.main.url(forResource: "natinfdb", withExtension: "plist") {
            do {
                let natinfdbPlistData = try Data(contentsOf: natinfdbPlistPath)
                
                if let natinfdb = try PropertyListSerialization.propertyList(from: natinfdbPlistData, options: [], format: nil) as? [[String: Any]] {
                    
                    _natinfItems = natinfdb

                }
                
            } catch {
                print(error)
            }
        }
        
        // MARK: - Création du tableau d'objet NATINF à partir du tableau brut de données.
        
        for i in 0 ... (_natinfItems.count) - 1 {
            
            _natinfsArray.append(Natinf(qualificationPVe: _natinfItems[i]["QualificationPVe"] as! String, qualification: _natinfItems[i]["Qualification"] as! String, natinf: _natinfItems[i]["Natinf"] as! Int, classe: _natinfItems[i]["Classe"] as! Int, montant_amende: _natinfItems[i]["Montant_amende"] as! Int, montant_amende_minore: _natinfItems[i]["Montant_minore"] as! Int,famille: _natinfItems[i]["Famille"] as! String, retrait_de_point: _natinfItems[i]["Retrait_points"] as? Int ?? 0, infraction_prevu: (_natinfItems[i]["Prevu"] as? String)!, infraction_reprime: _natinfItems[i]["Reprime"] as! String))
       
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        state = UserDefaults.standard.bool(forKey: SettingViewController.OPTION_SEARCH_NATINF)
        
    }

     // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if isFiltering {
       // if searchController.isActive && searchController.searchBar.text != "" {
            return _filteredsNatinfArray.count
       
        } else {
        
        return self._natinfsArray.count
        }
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NatinfTableViewCell! = (tableView.dequeueReusableCell(withIdentifier: "cell") as! NatinfTableViewCell)
        let natinf: Natinf
        if searchController.isActive && searchController.searchBar.text != "" {
            natinf = _filteredsNatinfArray[indexPath.row]
            cell.ui_qualification_label.text = String(natinf.natinf) + "- "  +  natinf.qualificationPVe + "\n"
            
        } else {
            let natinf = _natinfsArray [indexPath.row]
            cell.ui_qualification_label.text = String(natinf.natinf) + "- " +  natinf.qualificationPVe + "\n"
            
            
        }
        return cell
    
    
    }
  


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "segueDetailNatinf" {
            if let cell = sender as? UITableViewCell {
                if let indexPath = self.tableView.indexPath(for: cell) {
                    if isFiltering {
                        selectedNatinf = _filteredsNatinfArray[indexPath.row]
                    } else {
                        selectedNatinf = _natinfsArray[indexPath.row]
                    }
                    
                    let detailNatinfViewController:DetailNatinfViewController = segue.destination as! DetailNatinfViewController
                    detailNatinfViewController.natinfNatinf = selectedNatinf
                }
               
            }
        }
    
    }
    
// MARK: - Module gestion barre de recherche
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            filteredNatinfFromSearchBar(for: text)
        }
     
    }
    
    func filteredNatinfFromSearchBar(for searchText:String)   {
        
        if state == false {
        
        _filteredsNatinfArray = _natinfsArray.filter({ (natinf:Natinf) -> Bool in
                return
            natinf.qualification.lowercased().contains(searchText.lowercased())
           
        })
        
        } else {
            _filteredsNatinfArray = _natinfsArray.filter({ (natinf:Natinf) -> Bool in
                    return
                String(natinf.natinf).contains(searchText)
               
            })
        }
        tableView.reloadData()
    
    }

    
}
