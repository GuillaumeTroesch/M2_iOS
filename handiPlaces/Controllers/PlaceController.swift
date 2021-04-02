//
//  PlaceController.swift
//  handiPlaces
//
//  Created by tp on 01/04/2021.
//

import UIKit

class PlaceController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func gotoWebSite() {
        //TODO passer le site
        let vc = storyboard?.instantiateViewController(identifier: "websiteController") as! WebsiteController
//        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addFavorite() {
        //TODO verifier si deja dans favoris
        let defaults = UserDefaults.standard
        var arr = defaults.stringArray(forKey: "fav") ?? [String]()
        arr.append("newID")
        defaults.set(arr,forKey: "fav")
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
