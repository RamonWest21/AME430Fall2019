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
    
}
