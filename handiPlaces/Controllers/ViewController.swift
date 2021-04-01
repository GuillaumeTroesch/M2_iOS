//
//  ViewController.swift
//  handiPlaces
//
//  Created by tp on 25/03/2021.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //PickerView Initialisation
    @IBOutlet weak var pickerDepartement: UIPickerView!
    @IBOutlet weak var pickerHandicap: UIPickerView?
    
    var departements = [] as [String]
    var handicaps = ["Handicap mental", "Handicap visuel", "Handicap auditif", "Handicap moteur"]
    
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
    

//    @IBOutlet weak var departement: UITableView!
//    @IBOutlet weak var handicap: UITableView?
//    @IBOutlet weak var villeField: UIButton!
    
    
    
    
    //var urlAPI = "https://data.iledefrance.fr/explore/dataset/cartographie_des_etablissements_tourisme_handicap/api/"
    var urlDeBase = "https://data.iledefrance.fr/api/records/1.0/search/?dataset=cartographie_des_etablissements_tourisme_handicap"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .red
        
        pickerDepartement.delegate = self
        pickerDepartement.dataSource = self
        connectionAPI()
    }
    
    func connectionAPI() {
        let texteURL = "\(urlDeBase)&q=&facet=departement"
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
//                    let dataString = String(data: data, encoding: .utf8)
//                    print(dataString!)
                    
                    let dataDecode = JSONDecoder()
                    do {
                        let donnee = try dataDecode.decode(Donnee.self, from: data)
                        print(donnee.facet_groups[0].facets)
                    
//                        self.departements=[donnee.facet_groups[0].facets[0].name]
                        
                        
                        //TODO pas suffisant, les donnees ne sont a jour que quand on scroll
                        
                        DispatchQueue.main.async {
                         self.departements=[donnee.facet_groups[0].facets[0].name]
                            self.pickerDepartement.delegate = self
                         
//                            self.tempLabel.text = String(format: "%.1f", donnee.main.temp)
//                            self.villeLabel.text = donnee.name
//                            self.imageConditionMeteo.image = UIImage(systemName: self.nomImage(id: donnee.weather[0].id))
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
