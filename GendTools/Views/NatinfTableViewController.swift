//
//  NatinfTableViewController.swift
//  GendTools
//
//  Created by Pascal Ormancey on 09/01/2021.
//

import UIKit

class NatinfTableViewController: UITableViewController {
    
    var _natinfItems = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let filePath = Bundle.main.path(forResource: "natinfdb", ofType: "plist")
        _natinfItems = NSArray(contentsOfFile: filePath!) as! [[String:Any]]
       
    }

    // MARK: - Table view data source

   /* override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self._natinfItems.count
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
    

}
