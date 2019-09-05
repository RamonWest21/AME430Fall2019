//
//  Canon.swift
//  Computation Interface
//
//  Created by student on 9/5/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

class CanonBall {
    
    var force: Double
    var mass: Double
    var angle: Double
    
    init() {
        force = 0
        mass = 0
        angle = 0
    }
    
    func calculateDistanceTraveled(){
       
            var distance = force * cos(angle)
    }
    
    func calculateTimeTraveled() {
        // var time =
        
        // distY = ft - mgt
        // distanceY = force*sin(angle)*time - mass*g*time
        // time = ((force * sine(angle)) - (mass * gravity)) / distanceY
    }
   
    
    
}
