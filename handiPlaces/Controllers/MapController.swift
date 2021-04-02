//
//  WebsiteController.swift
//  handiPlaces
//
//  Created by tp on 01/04/2021.
//

import UIKit
import MapKit

class MapController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Placer une région dans la carte
        
        let latitude:CLLocationDegrees = 47.845665
        
        let longitude:CLLocationDegrees = 1.939773
        
        let latDelta:CLLocationDegrees = 0.05
        
        let lonDelta:CLLocationDegrees = 0.05
        
        let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegion.init(center: location, span: span)
        
        map.setRegion(region, animated: true)
        
        
        // Placer l'annotation
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        
        annotation.title = "Département d'informatique"
        
        annotation.subtitle = "J'y suis tout le temps..."
        
        map.addAnnotation(annotation)
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
