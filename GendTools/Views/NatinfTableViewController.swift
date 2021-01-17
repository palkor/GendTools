//
//  NatinfTableViewController.swift
//  GendTools
//
//  Created by Pascal Ormancey on 09/01/2021.
//

import UIKit

class NatinfTableViewController: UITableViewController, UISearchResultsUpdating {
   
    
    var _natinfItems = [[String:Any]]() // Tableau de dictionnaires du fichier PLIST
    var _natinfsArray = [Natinf]()  // tableau avec objets NATINF
    var _filteredsNatinfArray = [Natinf]() // tableau résultats searchBar
    let searchController = UISearchController(searchResultsController: nil) // barre de recherche

    override func viewDidLoad() {
        super.viewDidLoad()
       
    // MARK: - Paramètrage de la barre de recherche
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Recherche d'infraction"
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
        
        for i in 0 ... (_natinfItems.count) - 1 {
            
          _natinfsArray.append(Natinf(qualification: _natinfItems[i]["QualificationPVe"] as! String, natinf: _natinfItems[i]["Natinf"] as! Int, classe: _natinfItems[i]["Classe"] as! Int, montant_amende: _natinfItems[i]["Montant_amende"] as! Int, montant_amende_minore: _natinfItems[i]["Montant_minore"] as! Int, famille: _natinfItems[i]["Famille"] as! String))
    
        }
        
    }

     // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self._natinfsArray.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NatinfTableViewCell! = (tableView.dequeueReusableCell(withIdentifier: "cell") as! NatinfTableViewCell)
        let natinfItem = self._natinfItems[indexPath.row]
        cell.ui_qualification_label.text = natinfItem["QualificationPVe"] as? String
        return cell
    }
  


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetailNatinf" {
            if let cell = sender as? UITableViewCell {
                if let indexPath = self.tableView.indexPath(for:cell){
                    let selectedNatinf = _natinfItems[indexPath.row]
                    let detailViewController: DetailNatinfViewController = segue.destination as! DetailNatinfViewController
                    detailViewController.natinfSelected = selectedNatinf
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
        _filteredsNatinfArray = _natinfsArray.filter({ (natinf:Natinf) -> Bool in
            return
                natinf.qualification.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    
}
