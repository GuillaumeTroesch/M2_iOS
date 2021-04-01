//
//  Donnee.swift
//  handiPlaces
//
//  Created by Jean-Pacôme Delmas on 31/03/2021.
//

import Foundation

// Decodable est utilisé qd on a besoin de récupérer la donnée depuis un format extétieur (fichier JSON par exemple)

struct Departement : Decodable {
    var name : String
}

struct FacetGroups : Decodable {
    var name : String
    var facets : [Departement]
}

struct Field : Decodable {
    var etablissement : String
    var ville : String
    var departement : String
    var handicap_moteur : String
    var handicap_mental : String
    var handicap_visuel : String
    var handicap_auditif : String
}

struct Records : Decodable {
    var recordid : String
    var fields : [Field]
}

struct Donnee : Decodable {
    var nhits : Int
    var facet_groups : [FacetGroups]
    var records : [Records]
}
