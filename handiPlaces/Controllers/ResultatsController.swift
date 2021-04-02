//
//  ResultatsController.swift
//  handiPlaces
//
//  Created by tp on 01/04/2021.
//

import UIKit

class ResultatsController: UITableViewController {
    
    var optionRows : Int = 10
    var optionDepartement : String = ""
    var optionHandicaps : [String] = []
    
    var lieux : [Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(optionRows)
//        print(optionDepartement)
        connectionAPI()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4 ///TODO nombre de lignes
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototype1", for: indexPath)

        // Configure the cell
        
//        cell.textLabel?.text = "Titre"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let DvC = Storyboard.instantiateViewController(withIdentifier: "placeController") as! PlaceController
        tableView.deselectRow(at: indexPath, animated: true)

//        DvC.imageCurrent = headlines[indexPath.row].image
//        DvC.titleCurrent = headlines[indexPath.row].title
//        DvC.desriptionCurrent = headlines[indexPath.row].text
        
        self.navigationController?.pushViewController(DvC, animated: true)
    }
    
    func connectionAPI() {
        var texteURL = "\(Constant.urlDeBase)\(Constant.urlOption)\(Constant.urlOptionDepartements)\(Constant.urlOptionNbRows)\(optionRows)\(Constant.urlOptionDepartement)\(optionDepartement)"
        for handicap in optionHandicaps {
            switch handicap {
            case Constant.handicap_mental:
                texteURL += "&\(handicap)=oui"
            case Constant.handicap_moteur:
                texteURL += "&\(handicap)=oui"
            case Constant.handicap_visuel:
                texteURL += "&\(handicap)=oui"
            case Constant.handicap_auditif:
                texteURL += "&\(handicap)=oui"
            default: break
            }
        }
        
        let urlEncodee = texteURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard urlEncodee != nil else { debugPrint("Problème d'encodage de l'URL : \(texteURL)"); return }
        let url = URL(string: urlEncodee!)
        
        let session = URLSession(configuration: .default)
        let tache = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("Problème lors de la requête : \(error!)")
            } else {
                print("OK")
                if let data = data {
                    let dataDecode = JSONDecoder()
                    do {
                        let donnee = try dataDecode.decode(Donnee.self, from: data)
                        
                        DispatchQueue.main.async {
                            self.optionRows = donnee.nhits
                            for record in donnee.records
                            {
                                self.lieux.append(record)
                            }
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                } else {
                    print("Aucune donnée retournée")
                }
            }
        }
        tache.resume()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
