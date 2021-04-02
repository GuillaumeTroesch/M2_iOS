//
//  PlaceController.swift
//  handiPlaces
//
//  Created by tp on 01/04/2021.
//

import UIKit

class PlaceController: UIViewController {

    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var activite: UILabel!
    @IBOutlet weak var adresse: UILabel!
    @IBOutlet weak var ville: UILabel!
    @IBOutlet weak var departement: UILabel!
    @IBOutlet weak var handicapMental: UIImageView!
    @IBOutlet weak var handicapAuditif: UIImageView!
    @IBOutlet weak var handicapVisuel: UIImageView!
    @IBOutlet weak var handicapMoteur: UIImageView!
    var website : String = ""
    var lat : Float = 0
    var lon : Float = 0
    
    let defaults = UserDefaults.standard
    @IBOutlet weak var btnAddFav: UIButton!
    var recordid: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isInFavoris(id: "test") {
            btnAddFav.setTitle("Retirer des favoris", for: .normal)
        }
        print(recordid)
        connectionAPI()
    }
    
    @IBAction func gotoWebSite() {
        //TODO passer le site
        let vc = storyboard?.instantiateViewController(identifier: "websiteController") as! WebsiteController
        vc.website = website
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func gotoMap() {
        //TODO passer le site
        let vc = storyboard?.instantiateViewController(identifier: "mapController") as! MapController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addFavorite() {
        
        var arr = defaults.stringArray(forKey: "favo") ?? [String]()
        arr.append(recordid)
        defaults.set(arr,forKey: "favo")
    }
    
    func isInFavoris(id: String) -> Bool {
        let arr = defaults.stringArray(forKey: "favo") ?? [String]()
        for str in arr {
            if str==id {
                return true
            }
        }
        return false
    }
    
    func connectionAPI() {
        var texteURL = "\(Constant.urlDeBase)\(Constant.urlOption)recordid=\"" + recordid +
            "\""
        print(texteURL)
        
        let urlEncodee = texteURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard urlEncodee != nil else { debugPrint("Problème d'encodage de l'URL : \(texteURL)"); return }
        let url = URL(string: urlEncodee!)
        
        let session = URLSession(configuration: .default)
        let tache = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("Problème lors de la requête : \(error!)")
            } else {
                if let data = data {
                    let dataDecode = JSONDecoder()
                    do {
                        let donnee = try dataDecode.decode(DonneePlace.self, from: data)
                        
                        DispatchQueue.main.async {
                            print(donnee)
                            for record in donnee.records //normalement, 1 seul resultat
                            {
                                self.nom.text = record.fields.etablissement
                                self.ville.text = record.fields.ville
                                self.departement.text = record.fields.departement
                                self.adresse.text = record.fields.adresse
                                self.activite.text = record.fields.activit
                                self.website = record.fields.siteweb ?? ""
                                self.handicapMental.isHidden = record.fields.handicap_mental == "Non"
                                self.handicapAuditif.isHidden = record.fields.handicap_auditif == "Non"
                                self.handicapVisuel.isHidden = record.fields.handicap_visuel == "Non"
                                self.handicapMoteur.isHidden = record.fields.handicap_moteur == "Non"
                                
                               
//                                self.lat = record.fields.geo[0]
//                                self.lon = record.fields.geo[1]
                            }
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
