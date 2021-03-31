//
//  ViewController.swift
//  handiPlaces
//
//  Created by tp on 25/03/2021.
//

/*import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
    }


}
 */

//
//  ViewController.swift
//  API
//
//  Created by Ali ED-DBALI on 11/03/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var departement: UITableView!
    @IBOutlet weak var handicap: UITableView?
    @IBOutlet weak var villeField: UIButton!
    
    var urlAPI = "https://data.iledefrance.fr/explore/dataset/cartographie_des_etablissements_tourisme_handicap/api/"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        connectionAPI()
    }
    
    func connectionAPI() {
        let texteURL = "\(urlAPI)"
        let urlEncodee = texteURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard urlEncodee != nil else { debugPrint("Problème d'encodage de l'URL : \(texteURL)"); return }
        let url = URL(string: urlEncodee!)
        
        let session = URLSession(configuration: .default)
        let tache = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("Problème lors de la requête : \(error!)")
            } else {
                /*
                if let data = data {
                    // let dataString = String(data: data, encoding: .utf8)
                    // print(dataString!)
                    let dataDecode = JSONDecoder()
                    do {
                        let donnee = try dataDecode.decode(Donnee.self, from: data)
                        print(donnee.name)
                        print(donnee.main.temp)
                        print(donnee.weather[0].id)
                        DispatchQueue.main.async {
                            self.tempLabel.text = String(format: "%.1f", donnee.main.temp)
                            self.villeLabel.text = donnee.name
                            self.imageConditionMeteo.image = UIImage(systemName: self.nomImage(id: donnee.weather[0].id))
                        }
                    } catch {
                        print(error)
                    }
                } else {
                    print("Aucune donnée retournée")
                }
                 */
            }
        }
        tache.resume()
    }

}
