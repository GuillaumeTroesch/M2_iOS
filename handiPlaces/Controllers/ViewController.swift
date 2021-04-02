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
    var departementSelected : String = ""
    
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        departementSelected = departements[row]
    }
    //Fin PickerView Initialisation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerDepartement.delegate = self
        pickerDepartement.dataSource = self
        connectionAPI()
    }
    
    func connectionAPI() {
        let texteURL = "\(Constant.urlDeBase)\(Constant.urlOption)\(Constant.urlOptionDepartements)"
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
    
    func rechercher() {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let DvC = Storyboard.instantiateViewController(withIdentifier: "ResultatsController") as! ResultatsController

        DvC.optionRows = nbTotalLieux
        DvC.optionDepartement = departementSelected
        
        self.navigationController?.pushViewController(DvC, animated: true)
    }

}
