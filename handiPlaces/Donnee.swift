//
//  Donnee.swift
//  handiPlaces
//
//  Created by Jean-Pacôme Delmas on 31/03/2021.
//

import Foundation

// Decodable est utilisé qd on a besoin de récupérer la donnée depuis un format extétieur (fichier JSON par exemple)

/*struct Departement : Decodable {
    var id : int
    var 
}*/

struct Main : Decodable {
    var temp : Double
}

struct Donnee : Decodable {
    var name : String
    var main : Main
    var weather: [Info]
}

struct Info : Decodable {
    var id : Int
    var description : String
    var icon : String
}
