//
//  ViewController.swift
//  Computation Interface
//
//  Created by student on 9/5/19.
//  Copyright © 2019 student. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var ball: CanonBall!
    
    
    @IBOutlet weak var forceField: NSTextField!
    @IBOutlet weak var massField: NSTextField!
    @IBOutlet weak var angleField: NSTextField!
    @IBOutlet weak var distanceField: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ball = CanonBall()
        
        
    }

    @IBAction func fieldAction(_ sender: Any) {
        ball.force = forceField.doubleValue
        ball.mass = massField.doubleValue
        ball.angle = angleField.doubleValue
        
        print("force: ", ball.force)
        print("mass: ", ball.mass)
        print("angle: ", ball.angle)
    }


}

