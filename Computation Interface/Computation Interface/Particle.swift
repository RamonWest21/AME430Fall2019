//
//  Canon.swift
//  Computation Interface
//
//  Created by student on 9/5/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

class Particle{
    
    var xPosition: Double
    var yPosition: Double
    var zPosition: Double
    
    var distance: Double {
        get {
            return sqrt((xPosition * xPosition) + (yPosition * yPosition) + (zPosition * zPosition))
        }
    }
    
    init() {
        xPosition = 0
        yPosition = 0
        zPosition = 0
    }
    
    
    
    // format strings for text fields
    func format(value: Double) -> String{
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        let number = NSNumber(value: value)
        if let str = formatter.string(from: number){
            return str
        }
        else{
            return "not a number"
        }
    }
    
    func xPositionFormatted() -> String {
        return format(value: xPosition)
    }
    
    func yPositionFormatted() -> String {
        return format(value: yPosition)
    }
    
    func zPositionFormatted() -> String {
        return format(value: zPosition)
    }
    
    func distanceFormatted() -> String {
        return format(value: distance)
    }
    
    
}
