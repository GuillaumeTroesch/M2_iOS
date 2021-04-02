//
//  Donnee.swift
//  handiPlaces
//
//  Created by Jean-Pacôme Delmas on 31/03/2021.
//

import Foundation

struct Constant {
    static let urlDeBase = "https://data.iledefrance.fr/api/records/1.0/search/?dataset=cartographie_des_etablissements_tourisme_handicap"
    static let urlOption = "&q="
    static let urlOptionDepartements = "&facet=departement"
    static let urlOptionDepartement = "&departement="
    static let urlOptionNbRows = "&rows="
    static let urlOptionRecordid = "&recordid="
    static let handicap_auditif = "handicap_auditif"
    static let handicap_mental = "handicap_mental"
    static let handicap_visuel = "handicap_visuel"
    static let handicap_moteur = "handicap_moteur"
}

// Decodable est utilisé qd on a besoin de récupérer la donnée depuis un format extétieur (fichier JSON par exemple)

struct Departement : Decodable {
    var name : String
}

struct FacetGroups : Decodable {
    var name : String
    var facets : [Departement]
}

struct Field : Decodable {
    var etablissement : String?
    var ville : String?
    var departement : String?
    var handicap_moteur : String?
    var handicap_mental : String?
    var handicap_visuel : String?
    var handicap_auditif : String?
    var adresse : String?
}

struct Record : Decodable {
    var recordid : String
    var fields : Field
}

struct Donnee : Decodable {
    var nhits : Int
    var facet_groups : [FacetGroups]
    var records : [Record]
}
