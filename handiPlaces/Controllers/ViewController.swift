//
//  ViewController.swift
//  handiPlaces
//
//  Created by tp on 25/03/2021.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var departements = [] as [String]
    var handicaps = ["Handicap mental", "Handicap visuel", "Handicap auditif", "Handicap moteur"]
    var nbTotalLieux : Int = 0
    
    //PickerView Initialisation
    @IBOutlet weak var pickerDepartement: UIPickerView!
    @IBOutlet weak var pickerHandicap: UIPickerView?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return departements.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return departements[row]
    }
    //Fin PickerView Initialisation
    
    let urlDeBase = "https://data.iledefrance.fr/api/records/1.0/search/?dataset=cartographie_des_etablissements_tourisme_handicap"
    let urlOption = "&q="
    let urlOptionDepartement = "&facet=departement"
    let urlOptionNbRows = "&rows="
    let urlOptionRecordid = "&recordid="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerDepartement.delegate = self
        pickerDepartement.dataSource = self
        connectionAPI()
    }
    
    func connectionAPI() {
        let texteURL = "\(urlDeBase)\(urlOption)\(urlOptionDepartement)"
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
                            self.nbTotalLieux = donnee.nhits
                            for facet in donnee.facet_groups[0].facets
                            {
                                self.departements.append(facet.name)
                            }
                            self.pickerDepartement.delegate = self
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

}
