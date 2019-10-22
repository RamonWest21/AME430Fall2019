//
//  people.swift
//  StarWarsAPI
//
//  Created by student on 10/22/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

struct people: Decodable {
    var name: String
    var height: String
    var birthYear: String
    var gender: String
    var homeworld: String
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        name = try container.decode(String.self)
        height = try container.decode(String.self)
        birthYear = try container.decode(String.self)
        gender = try container.decode(String.self)
        homeworld = try container.decode(String.self)
    }
}
