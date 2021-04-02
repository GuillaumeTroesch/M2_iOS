//
//  WebsiteController.swift
//  handiPlaces
//
//  Created by tp on 01/04/2021.
//

import UIKit
import WebKit

class WebsiteController: UIViewController {

    @IBOutlet var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webview.load(URLRequest(url: URL(string: "https://www.google.fr")!))
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
