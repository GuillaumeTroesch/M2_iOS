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

struct Donnee : Decodable {
    var facet_groups : [FacetGroups]
}
