//
//  DistanceCalculator.swift
//  Computation Interface
//
//  Created by student on 9/11/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

class DistanceCalculator{
    
    var xDistance: Double
    var yDistance: Double
    var zDistance: Double
    
    init(){
        xDistance = 0
        yDistance = 0
        zDistance = 0
    }
    
    func getXDist(x1: Double, x2: Double) -> Double {
        xDistance = x2 - x1
        return xDistance
    }
    
    func getyDist(y1: Double, y2: Double) -> Double {
        yDistance = y2 - y1
        return yDistance
    }
    
    func getzDist(z1: Double, z2: Double) -> Double {
        zDistance =  z2 - z1
        return zDistance
    }
    
    func totalDist( )-> Double{
        var sumOfSquares = (xDistance * xDistance) + (yDistance * yDistance) + (zDistance * zDistance)
        return sqrt(sumOfSquares)
    }
    
    
}
