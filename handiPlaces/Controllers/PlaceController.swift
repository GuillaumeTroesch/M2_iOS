//
//  PlaceController.swift
//  handiPlaces
//
//  Created by tp on 01/04/2021.
//

import UIKit

class PlaceController: UIViewController {

    let defaults = UserDefaults.standard
    @IBOutlet weak var btnAddFav: UIButton!
    var recordid: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isInFavoris(id: "test") {
            btnAddFav.setTitle("Retirer des favoris", for: .normal)
        }
    }
    
    @IBAction func gotoWebSite() {
        //TODO passer le site
        let vc = storyboard?.instantiateViewController(identifier: "websiteController") as! WebsiteController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func gotoMap() {
        //TODO passer le site
        let vc = storyboard?.instantiateViewController(identifier: "mapController") as! MapController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addFavorite() {
        //TODO verifier si deja dans favoris
        print("AH")
        var arr = defaults.stringArray(forKey: "fav") ?? [String]()
        arr.append("newID")
        defaults.set(arr,forKey: "fav")
        print(isInFavoris(id: "x1"))
    }
    
    func isInFavoris(id: String) -> Bool {
        let arr = defaults.stringArray(forKey: "fav") ?? [String]()
        for str in arr {
            if str==id {
                return true
            }
        }
        return false
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
