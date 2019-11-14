//
//  Score.swift
//  FlappyBird
//
//  Created by Loren Olson on 11/13/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation


class Score: NSObject, NSCoding {
    var name: String
    var points: Int
    
    init(name: String, points: Int) {
        self.name = name
        self.points = points
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.points = aDecoder.decodeInteger(forKey: "points")
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(points, forKey: "points")
    }
}
