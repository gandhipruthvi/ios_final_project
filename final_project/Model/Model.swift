//
//  Model.swift
//  final_project
//
//  Created by Pruthvi Gandhi on 2021-12-12.
//

import Foundation

struct Result : Codable {
    var results : [Info]
}

struct Info : Codable {
    var product_ndc : String
    var generic_name : String
    var labeler_name : String
    var active_ingredients : [Ingredients]
    var dosage_form : String
    var product_type : String
}

struct Ingredients : Codable {
    var name : String
    var strength : String
}
